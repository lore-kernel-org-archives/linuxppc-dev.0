Message-ID: <37D97A85.B1515C05@loomer.com>
Date: Fri, 10 Sep 1999 14:39:17 -0700
From: Hugh Caley <hcaley@loomer.com>
MIME-Version: 1.0
To: Franz.Sirl@munich.netsurf.de, linuxppc-dev@lists.linuxppc.org
Subject: soinit.c and Mozilla segfaults
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Franz.  I'm having some problems running builds of Mozilla, and it seems
to be related to glibc.  I hope you don't mind me asking you about this...I'm
using the glibc v2.1.2 and gcc 2.95.1 from your directory on
dev.linuxppc.org.  This happens on builds of their main tree, and also with
the "milestone" builds.

Using gdb, I get my first error here:

Program received signal ?, Unknown signal.
0xf6a1fe4 in __syscall_rt_sigsuspend () at soinit.c:59
soinit.c:59: No such file or directory.

I don't have a file called soinit.c on my machine.

The output of bt is :

(gdb) bt
#0  0xf6a1fe4 in __syscall_rt_sigsuspend () at soinit.c:59
#1  0xf6a0d14 in __sigsuspend (set=0x7fffde68)
    at ../sysdeps/unix/sysv/linux/sigsuspend.c:48
#2  0xfd4245c in __pthread_create_2_1 (thread=0x7fffdf9c, attr=0x7fffdf18,
    start_routine=0xfd910d8 <_pt_root>, arg=0x100d67b0) at restart.h:32
#3  0xfd91608 in _PR_CreateThread ()
#4  0xfd91770 in PR_CreateThread ()
#5  0xfe90da8 in nsThread::Init ()
#6  0xfe91594 in NS_NewThread ()
#7  0xfe91bf8 in nsThreadPool::Init ()
#8  0xfe925e8 in NS_NewThreadPool ()
#9  0xef4127c in nsFileProtocolHandler::Init ()
#10 0xef41698 in nsFileProtocolHandler::Create ()
#11 0xfe85df8 in nsGenericFactory::CreateInstance ()
#12 0xfe82b58 in nsComponentManagerImpl::CreateInstance ()
#13 0xfe8bd2c in nsComponentManager::CreateInstance ()
#14 0xfe8cffc in nsServiceManagerImpl::GetService ()
#15 0xfe8da30 in nsServiceManager::GetService ()
#16 0xf0bcfc4 in nsService::nsService ()
#17 0xf0ac780 in nsIOService::GetProtocolHandler ()
#18 0xf0acb58 in nsIOService::NewURI ()
#19 0xf0acf08 in nsIOService::NewChannel ()
#20 0xef6a4bc in nsResourceProtocolHandler::NewChannel ()
#21 0xf0acdf4 in nsIOService::NewChannelFromURI ()
#22 0xffd5f44 in NS_OpenURI ()
#23 0xffbe9f8 in ImageNetContextImpl::GetURL ()
#24 0xffca2cc in IL_GetImage ()
#25 0xffc0f50 in ImageRequestImpl::Init ()
#26 0xffbc2c4 in ImageGroupImpl::GetImage ()
#27 0xf3959e4 in nsThrobber::LoadThrobberImages ()
#28 0xf3952ec in nsThrobber::Init ()
#29 0x100140f0 in nsBrowserWindow::CreateToolBar ()
#30 0x10013320 in nsBrowserWindow::Init ()
#31 0x1001caa0 in nsViewerApp::OpenWindow ()
#32 0x10022634 in nsNativeViewerApp::Run ()
#33 0x100229e8 in main ()
#34 0xf6992b4 in __libc_start_main () at
../sysdeps/powerpc/elf/libc-start.c:106

I'm not any kind of programmer, unfortunately.  Is this something to do with
glibc?

Hugh

--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
