Message-ID: <4124E315.9090009@eircom.net>
Date: Thu, 19 Aug 2004 18:27:49 +0100
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: Conor McLoughlin <cml3226@eircom.net>
Subject: PCI problem on MPC8250 target
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to debug a problem I have with a custom MPC8250 target
board. This board uses the 8250 host-pci bridge. Off the pci bus
there is a three-port pci-pci bridge. Hanging off one port of this
bridge are a number of DSP chips.

I am using kernel 2.6.8.1. I had been debugging this on 2.4.24 from
ELDK, but 2.6 appears to have resolved some of the problems I
had identified.

The pci bios appears to see both functions of the bridge and three
devices on bus 1.  The problem is in allocating resources for the
devices. I hope that someone here can save me some time and indicate
where I should be looking for the problem.

The hardware is first prototype and therefore no guarantees as to
how it is behaving.
A possible issue is that the bios only sees three out of four
DSPs. The first DSP (device number zero) is not seen. I have
been ignoring this problem for the moment, assuming that this is
some simple issue like device zero being special. We can easily
change the hardware to move this device number if that is the case.

PCI: Probing PCI hardware
PCI: bridge rsrc 0..ffffff (100), parent c0185008
PCI: bridge rsrc 80000000..9fffffff (1200), parent c0185024
PCI: bridge rsrc a0000000..afffffff (200), parent c0185024
PCI: bridge rsrc 0..fff (101), parent c01e6038
PCI: bridge rsrc 0..fffff (200), parent c01e6070
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: bridge 1 resource 1 moved to aff00000..afffffff
PCI: bridge rsrc 0..fffff (1201), parent c01e6054
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: bridge 1 resource 2 moved to 9ff00000..9fffffff
PCI: bridge rsrc 0..fff (101), parent c01e6038
PCI: reparented PCI Bus #01 [0..fff] under PCI Bus #02
PCI: bridge rsrc 0..fffff (200), parent c01e6070
PCI: Cannot allocate resource region 1 of PCI bridge 2
PCI: bridge 2 resource 1 moved to afe00000..afefffff
PCI: bridge rsrc 0..fffff (1201), parent c01e6054
PCI: Cannot allocate resource region 2 of PCI bridge 2
PCI: bridge 2 resource 2 moved to 9fe00000..9fefffff
PCI:0000:00:00.0: Resource 0: 00000000-0001ffff (f=200)
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI:  parent is c01e6070: a0000000-afffffff (f=200)
PCI:0000:00:00.0: Resource 1: 00000000-01ffffff (f=1208)
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
PCI:  parent is c01e6054: 80000000-9fffffff (f=1200)
PCI:0000:01:01.0: Resource 0: 00000000-003fffff (f=1208)
PCI: Cannot allocate resource region 0 of device 0000:01:01.0
PCI:  parent is c1fd2604: 9ff00000-9fffffff (f=1201)
PCI:0000:01:01.0: Resource 1: 00000000-007fffff (f=200)
PCI: Cannot allocate resource region 1 of device 0000:01:01.0
PCI:  parent is c1fd25e8: aff00000-afffffff (f=200)
PCI:0000:01:01.0: Resource 2: 00000000-0000000f (f=101)
PCI:0000:01:02.0: Resource 0: 00000000-003fffff (f=1208)
PCI: Cannot allocate resource region 0 of device 0000:01:02.0
PCI:  parent is c1fd2604: 9ff00000-9fffffff (f=1201)
PCI:0000:01:02.0: Resource 1: 00000000-007fffff (f=200)
PCI: Cannot allocate resource region 1 of device 0000:01:02.0
PCI:  parent is c1fd25e8: aff00000-afffffff (f=200)
PCI:0000:01:02.0: Resource 2: 00000000-0000000f (f=101)
PCI: Cannot allocate resource region 2 of device 0000:01:02.0
PCI:  parent is c1fd25cc: 00000000-00000fff (f=101)
PCI:0000:01:03.0: Resource 0: 00000000-003fffff (f=1208)
PCI: Cannot allocate resource region 0 of device 0000:01:03.0
PCI:  parent is c1fd2604: 9ff00000-9fffffff (f=1201)
PCI:0000:01:03.0: Resource 1: 00000000-007fffff (f=200)
PCI: Cannot allocate resource region 1 of device 0000:01:03.0
PCI:  parent is c1fd25e8: aff00000-afffffff (f=200)
PCI:0000:01:03.0: Resource 2: 00000000-0000000f (f=101)
PCI: Cannot allocate resource region 2 of device 0000:01:03.0
PCI:  parent is c1fd25cc: 00000000-00000fff (f=101)
PCI: Failed to allocate mem resource #0:400000@a0000000 for 0000:01:01.0
PCI: Failed to allocate mem resource #1:800000@b0000000 for 0000:01:01.0
PCI: Failed to allocate mem resource #0:400000@a0000000 for 0000:01:02.0
PCI: Failed to allocate mem resource #1:800000@b0000000 for 0000:01:02.0
PCI: Failed to allocate I/O resource #2:10@1000 for 0000:01:02.0
PCI: Failed to allocate mem resource #0:400000@a0000000 for 0000:01:03.0
PCI: Failed to allocate mem resource #1:800000@b0000000 for 0000:01:03.0
PCI: Failed to allocate I/O resource #2:10@1000 for 0000:01:03.0


Conor

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
