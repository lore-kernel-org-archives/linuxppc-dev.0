Message-Id: <5.1.0.14.2.20020104064034.0218c160@falcon.si.com>
Date: Fri, 04 Jan 2002 06:46:46 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Having linking problems with atomic_inc(),
  atomic_dec_and_test() in user app, help!
Cc: jeffk@jdkoftinoff.com
In-Reply-To: <02010319244002.11251@jeremy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 07:24 PM 1/3/2002 -0800, Jeremy Friesner wrote:

>Hi Linux Guys,
>
>I have what I hope is an easy question for you... I have am writing an
>user-space application that does some multithreading (using pthreads), and
>does some thread-safe reference counting by using the functions in
>asm/atomic.h.  Specifically, I'm using the atomic_inc(atomic_t *) and
>atomic_dec_and_test(atomic_t *) functions.
>
>Under Red Had Linux 7.1 on an Intel box, the program compiles and links fine.
>Under LinuxPPC 2.2.17-0.6.1, however, the link fails with the error output
>that is included below -- it fails whether I have optimization enabled (-O3),
>or not.  Is there some special library I need to link in, or magic compiler
>flag needed in order to access those functions?  Any advice?
>
>Also, what does "relocation truncated to fit: R_PPC_REL24 atomic_inc(atomic_t
>*)" mean?

This means the function wasn't found by the linker (as noted on the line
previous).  You need to find or write atomic_inc() and atomic_dec_and_test().

The linker apparently uses a bogus number to fill in for unresolved
addresses and then, later, tries to fill out a jump target offset to get to
that bogus address.  On the PPC, normal branches and subroutine calls are
24 bit relative values, so you cannot branch directly to 0x80000000 (for
instance) from location 0x000xxxxx (you can get there, but it involves
loading a register with the destination and then branching using the register).

gvb



>Thanks,
>Jeremy
>
>Begin link output--------------
>
>gcc  -o lxelcd Message.o AbstractMessageIOGateway.o MessageIOGateway.o
>String.o StorageReflectSession.o AbstractReflectSession.o
>DumbReflectSession.o ReflectServer.o StringMatcher.o PathMatcher.o
>NetworkUtilityFunctions.o SysLog.o Thread.o muscled.o FileDescriptorDataIO.o
>FilterSessionFactory.o PulseNode.o RateLimitSessionIOPolicy.o
>MemoryAllocator.o GlobalMemoryAllocator.o CCSysexMessageIOGateway.o
>CCModuleMessageIOGateway.o CCFrameMessageIOGateway.o CCSession.o
>CCModuleChainSession.o CCControlSession.o CCServer.o CCFrameSession.o
>CCComponentSession.o CCConfigFile.o CCRangeConvert.o CCModuleLogic.o
>CCTransportModuleLogic.o CCEditorModuleLogic.o CCMeterModuleLogic.o
>CCFaderModuleLogic.o CCBitPack.o CCFrameSubscription.o
>CCDynamicHardwareSession.o CCSoftMeterSession.o CCSoftMeterModuleLogic.o
>CCAbstractEditBoxModuleLogic.o CCEQEditBoxModuleLogic.o
>CCBusAssignEditBoxModuleLogic.o CCSoftGenericSession.o
>CCSoftGenericModuleLogic.o ControlPointSpec.o CCChannelInfo.o ccserverd.o
>ccconfigd.o LXADTPSession.o LXFakeStorage.o LXFakeFileStorage.o
>LXADTPIOGateway.o LXSCSIStorage.o lxaudiodtpd.o LXWTRXAudioIOGateway.o
>LXWTRXAudioSession.o LXWTRXIOGateway.o LXWTRXServer.o LXWTRXSession.o
>LXWTRXStatusIOGateway.o LXWTRXStatusSession.o tc.o lxwtrxd.o AsyncIORequest.o
>LXWTRXAsyncDiskIOSession.o SafetyNetDataIO.o LXTCPComSession.o
>LXTCPComIOGateway.o LXTCPHSBIOGateway.o LXTCPComServer.o lxtcpcomd.o lxelcd.o
>webserve.o sock.o filewebserve.o getframesstatus.o sendsysex.o watchalerts.o
>smallframestatus.o -lm -lpthread
>Message.o: In function `muscle::AtomicCounter::AtomicIncrement(void)':
>Message.o(.muscle::AtomicCounter::gnu.linkonce.t.AtomicIncrement(void)+0x24):
>undefined reference to `atomic_inc(atomic_t *)'
>Message.o(.muscle::AtomicCounter::gnu.linkonce.t.AtomicIncrement(void)+0x24):
>relocation truncated to fit: R_PPC_REL24 atomic_inc(atomic_t *)
>Message.o: In function `muscle::AtomicCounter::AtomicDecrement(void)':
>Message.o(.muscle::AtomicCounter::gnu.linkonce.t.AtomicDecrement(void)+0x24):
>undefined reference to `atomic_dec_and_test(atomic_t *)'
>Message.o(.muscle::AtomicCounter::gnu.linkonce.t.AtomicDecrement(void)+0x24):
>relocation truncated to fit: R_PPC_REL24 atomic_dec_and_test(atomic_t *)
>collect2: ld returned 1 exit status
>make: *** [lxelcd] Error 1
>[jaf@jonathan lxelcd]$
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
