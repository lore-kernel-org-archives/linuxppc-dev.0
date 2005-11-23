Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17284.62966.465034.114897@cargo.ozlabs.ibm.com>
Date: Thu, 24 Nov 2005 10:06:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051123223827.GA20793@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
	<20051119102952.GA32273@suse.de> <20051119172900.GA11829@suse.de>
	<20051119204742.GA17604@suse.de> <20051123202115.GA17320@suse.de>
	<17284.61088.219693.162392@cargo.ozlabs.ibm.com>
	<20051123223827.GA20793@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> Maybe I miss the point, but if the src is unaligned, and we align it,
> dest will change as well and may be unaligned?

Yes, but in aligning the dest you will unalign the source.  So with
your patch we will do something like copy 3 bytes, test, copy 1 byte,
test, go back, copy 3 bytes, test, copy 1 byte, etc., on and on until
the whole buffer is copied.  With my patch we get into one loop
copying the whole buffer byte-by-byte.

The other alternative is to work out the appropriate rotate amounts
and masks so that the main loop does load word, rotate, AND, AND, OR,
store word (a bit like the 64-bit kernel memcpy does, except it works
on doublewords not words).  That seems like a lot of trouble to go to
for the bootwrapper though.

Paul.
