Return-Path: <rmcguire@uwbt.com>
Received: from mail19a.g19.rapidsite.net (mail19a.dulles19-verio.com
	[204.202.242.24]) by ozlabs.org (Postfix) with SMTP id 9E598689D9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jan 2006 11:37:31 +1100 (EST)
Received: from mx33.stngva01.us.mxservers.net (204.202.242.74)
	by mail19a.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	4-0124218249 for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jan 2006 19:30:50 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Qt,  forks and threads = segmentation faults?
Date: Fri, 27 Jan 2006 16:30:42 -0800
Message-ID: <000301c623a2$13b98fc0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.126.1138386609.857.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Everyone,

This is a more general question, and if anyone knows of a more specialized
list this should be posted to, I'd be happy to do so...

Small picture of hardware:
DENX Linux 2.4.25 / PowerPC MPC8280 / 32 MBs of RAM

I am using QT Embedded for a small GUI that does BSD sockets, also using
DENX's SM501 video driver. Everything is quite stable, recently I added a
additional process to the application using fork() for the listening
'accept' call for the sockets.

After many tests I decided that due to the nature of the fork() command and
the GUI half of the program, that this was a large waste of memory, as I was
duplicating the entire GUI system. So I started looking alternatives, and
have landed at the 'pthread' library.

However, now I have lots of segmentation faults, particularly when I send a
message using QT's postEvent commands back to the main thread.

I was curious if anyone had any better idea of a more stable or perhaps a
suggestion on why I am able to only get about 30 seconds of run time out of
the app using pthread, verses fork() seems to be much stabler. 

-Russ
