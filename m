Message-ID: <3D80F2F7.3FB3AE4B@koffie.nl>
Date: Thu, 12 Sep 2002 22:03:02 +0200
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: RFC: Performance Monitor Counters device
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi people,

I'm currently implementing a Linux driver to use the PowerPC
performance monitor counters (PMC's).  I thought I'd ask here
about some design/implementation issues, before I do a lot
of stupid/timewasting things ;)

The goal of this driver is threefold:

1) provide an easy interface for programs to be able to monitor
   themselves -> need to change your programs code, very
   fine-grained profiling.
2) provide a little more capable interface to use with something
   like gmon.
3) and you can do all that on the kernel, too.

For 1), the program-to-be-monitored just needs to be able to
select a set of PMC's, and read the counters.  Pretty easy.

For 2), you need the same as for 1), plus have the kernel
generate a signal on every Nth occurence of some event.  The
PowerPC generates an exception for that, so this is not all
that hard either.  Maybe the kernel can communicate which PMC
set off the signal; if not, it's trivial for the userland to
figure that out from the current counters.

For 3), it's just the same as above, except the niggly details
I left out (that are needed there, too): you need to select
whether the counters count event in supervisor and/or in
problem state, and/or only on marked tasks.


Now the questions ;)

1) What's the best interface for this kind of thing?  A char
   device?  With ioctl()'s?  a sysctl?  something in /proc?
   I'm not interested in ease of implementation (I'll have to
   hack some on gprof too, for this -- so I'm not afraid of
   the kernel ;) ), but in what's philosophically/technically/
   procatically the best interface.
2) Do we want to be able to profile several tasks (independently
   from each other) at once?  This will require some bookkeeping
   and task switch overhead, and is probably not necessary in
   practice; also, it will degrade the quality of the results some.
3) [I'm ashamed I have to ask this...]  Is there a good tutorial
   to kernel locks somewhere?
4) Security: I want to generate most of the settings in userland,
   for maximum ease of use and ease of implementation; but that
   brings up some security issues.  Only allowing root to
   profile code isn't ideal, either.  So:
   a) Don't automagically load the module; if root loads it, let's
      hope he knows what he's doing;
   b) Have the pmc device be accessible only to a 'trusted' group;
   c) A setuid driver program to start profiling;
   d) Something much more clever?


Thanks to anyone who read this far,

Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
