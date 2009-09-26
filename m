Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221]) by ozlabs.org (Postfix) with ESMTP id 495C3B7BBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 22:00:07 +1000 (EST)
Received: by ewy21 with SMTP id 21so3135327ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 05:00:04 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 26 Sep 2009 14:00:04 +0200
Message-ID: <1ba63b520909260500k3b7a0ed1l2d75116053ae5522@mail.gmail.com>
Subject: Problem with futex call on 8xx
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi
I'm having a problem with ~100% CPU load on MPC8xx when calling
pthread_cond_wait.
Running strace, I get:

futex(0x10040d5c, FUTEX_WAIT, 1, NULL)  = -1 ENOSYS (Function not implemented)

.. and this call is inifinitely repeating, which explains the high load.

I'm running Linux 2.6.26-rc2 (not newer due to the slowdown problem
introduced by commit
8d30c14cab30d405a05f2aaceda1e9ad57800f36, as pointed out by Rex Feany
this week), and
glibc v2.6 (part of ELDK 4.2).

Is this a problem due to an error in the futex implementation in
glibc, or a kernel problem?

Best regards,
Frank
