From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14740.61112.962127.150660@argo.linuxcare.com.au>
Date: Sat, 12 Aug 2000 16:29:12 +1000 (EST)
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again... 
In-Reply-To: <Pine.HPX.4.10.10008081055160.20140-100000@gra-ux1.iram.es>
References: <14735.25805.953473.825729@argo.linuxcare.com.au>
	<Pine.HPX.4.10.10008081055160.20140-100000@gra-ux1.iram.es>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> > Certainly on my 7600 with a 2-cpu powersurge board, with the code that
> > is currently in the devel kernel to use the tb register, you don't get
> > the same time on both cpus.
>
> Yes, we need a way to check that the timebase are in sync and to sync
> them if they are not. That's basically the same problem in any case.
> The problem is to do it in a way that works on all machines...

Until we get SMP working on the 2-cpu G4 machines (hopefully I will be
getting one soon), the old powersurge board is the only supported SMP
powermac.  I found with mine that when you start the second CPU, it
stops the decrementers (and I expect timebases as well) on both CPUs
until you send an interrupt from the primary to the secondary cpu.

So on this platform at least, we can get the decrementers and
timebases synchronized.

> It does not toch so much when you look carefully at it, only timekeeping
> but it's basically an all or nothing (and some global variable name
> changes to be sure that I catch all the occurences which add somewhat to
> the patch size).

I merged in your patch and tried it on my 7600/powersurge machine.  It
seems to work just fine.

> I have still found bugs in my code (but it seems to be slowly converging).
> I'm also considering switching to BitKeeper tree, and sending these
> patches in smaller and more digestible chunks:

I'm going to try to update the linuxppc_2_3 bitkeeper tree to -test6,
since Cort is busy moving at the moment.  In the meantime I will
update the rsync tree at linuxcare.com.au::linux-pmac-devel with your
patch shortly.

The get/set rtc stuff on powermac still needs work.  IMHO the way it
should work on powermacs is this:

- at boot, read the RTC and the xpram and apply the correction from
  the xpram

- /dev/rtc reads and writes the RTC value directly (no timezone
  correction)

- if the RTC is updated from other places in the kernel, read the
  timezone recorded in xpram and apply that correction before writing
  it to the RTC.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
