Message-Id: <m144RWF-001SzYC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: 2.5 or 2.4 kernel profiling
To: ford@vss.fsi.com (Brian Ford)
Date: Fri, 8 Dec 2000 12:41:15 -0500 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.21.0012071210280.515-100000@eos> from "Brian Ford" at Dec 07, 2000 12:11:07 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I am trying to do some kernel profiling on my EST8260 to determine the
> bottle neck in TCP and UDP thruput, but I can't seem to get any profile
> information.

What version of Linux are you using?  I have tried the LTT, Linux
Trace Toolbox under 2.4.0-test11.  LTT tracks a large number of
events, so it may give you a better handle as to what is happening
when.

http://www.opersys.com/LTT

+Kernel events tracing support
+CONFIG_TRACE
+  It is possible for the kernel to log important events to a tracing
+  driver. Doing so, enables the use of the generated traces in order
+  to reconstruct the dynamic behavior of the kernel, and hence the
+  whole system.
+
+  The tracing process contains 4 parts :
+      1) The logging of events by key parts of the kernel.
+      2) The trace driver that keeps the events in a data buffer.
+      3) A trace daemon that opens the trace driver and is notified
+         every time there is a certain quantity of data to read
+         from the trace driver (using SIG_IO).
+      4) A trace event data decoder that reads the accumulated data
+         and formats it in a human-readable format.
+
+  If you say Y or M here, the first part of the tracing process will
+  always take place. That is, critical parts of the kernel will call
+  upon the kernel tracing function. The data generated doesn't go
+  any further until a trace driver registers himself as such with the
+  kernel. Therefore, if you answer Y, then the driver will be part of
+  the kernel and the events will always proceed onto the driver and
+  if you say M, then the events will only proceed onto the driver when
+  it's module is loaded. Note that event's aren't logged in the driver
+  until the profiling daemon opens the device, configures it and
+  issues the "start" command through ioctl().
+
+  The impact of a fully functionnal system (kernel event logging +
+  driver event copying + active trace daemon) is of 2.5% for core events.
+  This means that for a task that took 100 seconds on a normal system, it
+  will take 102.5 seconds on a traced system. This is very low compared
+  to other profiling or tracing methods.
+
+  For more information on kernel tracing, the trace daemon or the event
+  decoder, please check the following address :
+       http://www.opersys.com/LTT

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
