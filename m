Date: Fri, 10 Sep 1999 20:06:17 -0700
From: Hugh Caley <hcaley@loomer.com>
Subject: More with Mozilla and glibc
To: Franz.Sirl@munich.netsurf.de, linuxppc-dev@lists.linuxppc.org
Message-id: <37D9C729.6BED554E@loomer.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I upgraded to glibc-2.1.2-7b; same problem, it segfaults almost immediately.

Program received signal ?, Unknown signal.
0xf6a0e90 in Letext () at soinit.c:59
soinit.c:59: No such file or directory.

Backtrace is slightly different:

(gdb) bt
#0  0xf6a0e90 in Letext () at soinit.c:59
#1  0xf69fb78 in __sigsuspend (set=0x7fffde68)
    at ../sysdeps/unix/sysv/linux/sigsuspend.c:48
#2  0xfd424f4 in __pthread_create_2_1 (thread=0x7fffdf9c, attr=0xfd5c794,
    start_routine=0, arg=0x100d09c0) at restart.h:32
#3  0xfd91608 in _PR_CreateThread ()
#4  0xfd91770 in PR_CreateThread ()
#5  0xfe90da8 in nsThread::Init ()
#6  0xfe91594 in NS_NewThread ()
#7  0xfe91bf8 in nsThreadPool::Init ()
#8  0xfe925e8 in NS_NewThreadPool ()
#9  0xef4027c in nsFileProtocolHandler::Init ()
#10 0xef40698 in nsFileProtocolHandler::Create ()
#11 0xfe85df8 in nsGenericFactory::CreateInstance ()
#12 0xfe82b58 in nsComponentManagerImpl::CreateInstance ()
#13 0xfe8bd2c in nsComponentManager::CreateInstance ()
#14 0xfe8cffc in nsServiceManagerImpl::GetService ()
#15 0xfe8da30 in nsServiceManager::GetService ()
#16 0xf0bbfcc in nsService::nsService ()
#17 0xf0ab780 in nsIOService::GetProtocolHandler ()
#18 0xf0abb58 in nsIOService::NewURI ()
#19 0xf0abf08 in nsIOService::NewChannel ()
#20 0xef694bc in nsResourceProtocolHandler::NewChannel ()
#21 0xf0abdf4 in nsIOService::NewChannelFromURI ()
#22 0xffd5f44 in NS_OpenURI ()
#23 0xffbe9f8 in ImageNetContextImpl::GetURL ()
#24 0xffca2cc in IL_GetImage ()
#25 0xffc0f50 in ImageRequestImpl::Init ()
#26 0xffbc2c4 in ImageGroupImpl::GetImage ()
#27 0xf3949e4 in nsThrobber::LoadThrobberImages ()
#28 0xf3942ec in nsThrobber::Init ()
#29 0x100140f0 in nsBrowserWindow::CreateToolBar ()
#30 0x10013320 in nsBrowserWindow::Init ()
#31 0x1001caa0 in nsViewerApp::OpenWindow ()
#32 0x10022634 in nsNativeViewerApp::Run ()
#33 0x100229e8 in main ()
#34 0xf69841c in Letext () at ../sysdeps/powerpc/elf/libc-start.c:106



--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
