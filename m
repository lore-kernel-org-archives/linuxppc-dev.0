Message-ID: <5725AF6EE9FAD51195DC009027E377020B656263@az33exm35.corp.mot.com>
From: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: gt-64260 Question
Date: Tue, 25 Nov 2003 13:59:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


owner-linuxppc-embedded@lists.linuxppc.org wrote:
> Benjamin Davis wrote:
>
>> Errata 9 of
>> http://e-www.motorola.com/files/32bit/doc/errata/MPC7455CE.pdf
>> talks about some issues with QACK,
>
> Okay.
>
>> I further noticed how in arch/ppc/platform/pmac_feature.c, in
>>     probe_uninorth: if (uninorth_rev < 0x11) {
>>         actrl = UN_IN(UNI_N_ARB_CTRL) &
>>         ~UNI_N_ARB_CTRL_QACK_DELAY_MASK; actrl |= ((uninorth_rev <
>>             3) ? UNI_N_ARB_CTRL_QACK_DELAY105 :
>> UNI_N_ARB_CTRL_QACK_DELAY) <<
>> UNI_N_ARB_CTRL_QACK_DELAY_SHIFT;
>>         UN_OUT(UNI_N_ARB_CTRL, actrl);
>>
>> It would appear to me that a QACK delay is being set by communication
>> with the uninorth.  I will say now though this is my first
>> experiance with the kernel. I was kinda thinking they might have
>> gotten around the errata by extending the delay of the QACK.  This
>> QACK is the system saying it is time to get out of nap, and snoop.
>
> I don't see any reference in the 64260 manual that lets you control
> this.  Are you sure that you need to nap/snooze?  IOW, are you sure
> you're not solving a problem you don't have?

The 64260 does not implement the QACK power management protocol; most
boards just tie it off or connect it only to the COP/JTAG header.

So, you probably needn't worry about it.

 --
Gary Milliorn, Motorola       phone: 512 996.7066
PowerPC Development Platforms email: mailto:Gary.Milliorn@Motorola.com
Computing Platform Division

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
