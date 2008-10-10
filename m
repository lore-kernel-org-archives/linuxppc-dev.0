Return-Path: <domino@mikroswiat.pl>
Message-ID: <48EF8E29.1020101@mikroswiat.pl>
Date: Fri, 10 Oct 2008 19:17:29 +0200
From: Dominik Bozek <domino@mikroswiat.pl>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48ECC611.3030309@mikroswiat.pl>	<20081008154212.GA21723@secretlab.ca>	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>	<48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
In-Reply-To: <18669.58803.48011.686743@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Very interesting.  Can you work out where memcpy is being called on
> the network data?  I wouldn't have expected that.

Ok. I've some results.
I done two test with different MTU. In both cases, about 0.5GB in total
has been transfered over network. Large blocks.
The test didn't trace a "shallow copy", where occasionally memcpy() is
also in use.


1) MTU=1500 (on both host and mpc8313)
* achieved throughput: 22MB/s (from mpc), 16MB/s (to mpc)
* total size of copied data by memcpy() was 37.6MB
* 96% of that has been copied by skb_clone(): 787758 times in blocks of 48B.
* about 3% of that has been copied by skb_copy_bits(): 1013 times, the
block size vary but rather bigger like 1300B.
* about 1% of that has been copied by eth_header(): 80248 times in
blocks of 6B (!!!!).

2) MTU=9000 (on both host and mpc8313)
* achieved throughput: 50MB/s (from mpc), 44MB/s (to mpc)
* total size of copied data by memcpy() was 6.4MB
* 97% of that has been copied by skb_clone(): 134260 times in blocks of 48B.
* 3% (whole rest) has been copied by eth_header(): 32912 times in blocks
of 6B.

Conclusion. Need for optimized memcpy() for blocks 48B and 6B :). Joke.

I said earlier, that I got about 10% boost when I replaced memcpy() by
__copy_tofrom_user(). It was the case with MTU 9000 because I work with
that setting in my environment.

I don't know when __copy_tofrom_user get faster than memcpy on other
cpus than mpc8313, but on mpc8313 48B blocks are more suitable for
__copy_tofrom_user.

Dominik
