Date: Sat, 3 Feb 2001 11:27:05 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010203112705.A19223@allspice.cs.swarthmore.edu>
References: <20010130165710.B22219@allspice.cs.swarthmore.edu> <B69DFE88.9197%bootc@worldnet.fr> <20010201115015.A11149@allspice.cs.swarthmore.edu> <20010202023834.A17159@allspice.cs.swarthmore.edu> <14971.34502.222006.311092@diego.linuxcare.com.au> <20010203111427.B15855@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010203111427.B15855@allspice.cs.swarthmore.edu>; from eisenbud@cs.swarthmore.edu on Sat, Feb 03, 2001 at 11:14:27AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 03, 2001 at 11:14:27AM -0500, Daniel Eisenbud <eisenbud@cs.swarthmore.edu> wrote:
> On Sat, Feb 03, 2001 at 03:19:18PM +1100, Paul Mackerras <paulus@linuxcare.com.au> wrote:
[...]
> > Well, it could be declared in scsi.h but the actual table of values
> > should go in a .c file.
>
> My current patch has a static function in the new file scsi_dataout.h,
> which is included by all the drivers in question.   But I agree that it
> would be cleaner to declare the function in scsi.h, change
> scsi_dataout.h to scsi_dataout.c, make the function no longer static,
> and tell make about the dependencies.  I'll do that.

The advantage of my current approach is that there are two SCSI drivers
(for acorn and i2o) that use copies of this table but that live outside
of drivers/scsi.  They already include scsi.h, and it's easy to make
them include scsi_dataout.h.  For the files inside drivers/scsi, it's
easy to see how to make them depend on scsi_dataout.o, but it's not
obvious to me how it should work for files that live elsewhere.  Am I
missing something obvious?

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
