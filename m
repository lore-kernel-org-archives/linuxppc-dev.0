Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 12:46:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Add fast little-endian switch system call
In-Reply-To: <20080428144332.GA17109@lst.de>
References: <18453.18943.906693.409245@cargo.ozlabs.ibm.com>
	<20080428144332.GA17109@lst.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, mtk.manpages@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig writes:

> Am I missing something here or does this add a branch for every normal
> syscall?

It does, but the impact is so small as to be unmeasurable with
lmbench, even on the null syscall measurement.  The overhead of the
easily-predicted not-taken branch is completely swamped by the amount
of time that the sc and rfid instructions take.  I had it under a
config option at one point but then decided not to bother with that
when I couldn't measure any difference.

Paul.
