Message-ID: <3D5990D8.7010001@dslextreme.com>
Date: Tue, 13 Aug 2002 16:06:00 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: OCP Version 2 ( or "the other bus interface" tobi)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-- Draft version 0.1 --

Well here is a high level view of what I think bus support should be for
  processors that have re-usable funtional blocks such as the 4xx
family.  I wanted to get this out since providing the details is taking
me too long.  I do have a few questions and trade-offs that should to be
discused.  This interface can go beyond just ocp such as for external
devices.  Once the high level is done, then I can fill in the blanks for
the detail and get that out and possible code segments.



The biggest changes are Power Management, bus hiarchy and the new driver
model support.

There are three areas that are affected; Arhcitecture, core and drivers.

Architecure: provide flexability for each architecture to do any setup
priory invoking bus scanning such as ocp_init() that each arch defines,
and changes to the core_ocp to add define devices as a bridge, host or
normal device and what ever elase is needed.

Core: addition of bus scan technology , power management and
infustructure for new driver model.

1) how do we want to determine what device is on what bus?
	a) add a size for each device in the core_ocp[] and for any device
between the addr and size are on that bus

	b) Use order in the core_ocp[] to determine bus order and which device is
associated to which bus. ie devices between bridges are on a particular bus

	c) hardcode bus association in core_ocp[], ie added a bus_num field

2) change the device stuct so that is no longer contains an entire copy
of each devices core_ocp data.
	a) index
	b) pointer

3) Model how PCI did their pm call backs


Drivers: They need to be ported to support the driver model including
power managment call backs and for any other changes that happen in the
core.


We need to add in additional support beyond what ocp currently has
primary since there are more than 1 bus in any 4xx and if we want to
truely support pm then we need to deal with _all_ buses which is why I
think its more than ocp.

Feedback, comments , ideas and arrows

armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
