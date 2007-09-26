Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18170.60026.917774.234504@cargo.ozlabs.ibm.com>
Date: Thu, 27 Sep 2007 09:25:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: really old glibc on 8xx or 403 with bleeding-edge kernel -
	anyone care?
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since about May 2001, we have put two AT_IGNOREPPC entries at the
beginning of the ELF auxiliary vector.  The reason for this is that
glibc prior to April 2001 rounded up the address of the base of the
aux vector to a multiple of 16.  I think we can now get rid of the
AT_IGNOREPPC entries.

Well, in fact what old glibc did was a little more complex than that.
It worked out the standard aux vector base (i.e. the address of the
word after the end of the environment pointers), and then chose either
that or that address rounded up to a multiple of 16 bytes.  The way it
chose was by checking the word at the rounded address - if it was more
than 16 it used the standard base address, otherwise it used the
rounded address.

So the way the AT_IGNOREPPC hack worked was by putting 4 words (two
aux vector entries) at the beginning of the aux vector that all
contained the value 22 (AT_IGNOREPPC).  That made the old glibc code
choose the standard aux vector base address.

However, what comes after that is an AT_DCACHEBSIZE (19) entry and an
AT_ICACHEBSIZE (20) entry.  Thus, as long as the data cache blocksize
and the instruction cache blocksize are greater than 16, these two
entries will serve just as well as the AT_IGNOREPPC entries at making
old glibc choose the standard aux vector base address.

The only CPUs that we support with cache line sizes of 16 bytes or
less are the 8xx family and the 403 family.  So my question is, does
anyone care about running ancient userland binaries (from 2001 or
earlier) on 8xx or 403 with future kernels (2.6.x for x >= 24)?

If not then we can remove the AT_IGNOREPPC aux vector entries.

Paul.
