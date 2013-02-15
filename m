Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 97EE52C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 03:55:09 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 25182-05 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 15 Feb 2013 16:55:01 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH -V2 2/2] powerpc: Update kernel VSID range
Date: Fri, 15 Feb 2013 16:52:40 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B714E@saturn3.aculab.com>
In-Reply-To: <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1360942778-21795-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <phileas-fogg@mail.ru>,
 <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>   * The proto-VSIDs are then scrambled into real VSIDs with the
>   * multiplicative hash:
> ...
>   * VSID_MULTIPLIER is prime, so in particular it is
>   * co-prime to VSID_MODULUS, making this a 1:1 scrambling function.
>   * Because the modulus is 2^n-1 we can compute it efficiently without
> + * robust scattering in the hash * table (at least based on some =
initial
> + * results).

Are VSIDs a value that the kernel has a 'free choice' over the
value to allocate, and that only have to be unique over the
allocated values?

If so, instead of using hash chains it is probably better to
pick a free 'hash' table entry, and then allocate a VSID value
that maps directly into that table slot.
Reusing values can be avoided by incrementing the high bits
every time a table entry is reused, the free slots can also
easily be kept on a FIFO list.

If the table gets nearly full its size can be doubled (protect
with rcu?).

	David
