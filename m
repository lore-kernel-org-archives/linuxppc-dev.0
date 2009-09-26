Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221]) by ozlabs.org (Postfix) with ESMTP id E8E67B7BE7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 22:52:31 +1000 (EST)
Received: by ewy21 with SMTP id 21so3154331ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 05:52:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ba63b520909260500k3b7a0ed1l2d75116053ae5522@mail.gmail.com>
References: <1ba63b520909260500k3b7a0ed1l2d75116053ae5522@mail.gmail.com>
Date: Sat, 26 Sep 2009 14:52:29 +0200
Message-ID: <1ba63b520909260552q6c4da364t7c41082165a9fb@mail.gmail.com>
Subject: Re: Problem with futex call on 8xx
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'll answer myself, since I just found the solution to the problem -
with help from 'kos_tom'
at #uclibc on freenode.

The problem is caused by a missing 'CONFIG_FUTEX=3Dy' in the defconfig
for our target.

The system we're developing is based on the Adder port by Scott Wood, which=
 is
also missing this, so a patch should be committed for this and
possible other 8xx targets
as well.

Best regards,
Frank

On Sat, Sep 26, 2009 at 2:00 PM, Frank Svendsb=F8e
<frank.svendsboe@gmail.com> wrote:
> Hi
> I'm having a problem with ~100% CPU load on MPC8xx when calling
> pthread_cond_wait.
> Running strace, I get:
>
> futex(0x10040d5c, FUTEX_WAIT, 1, NULL) =A0=3D -1 ENOSYS (Function not imp=
lemented)
>
> .. and this call is inifinitely repeating, which explains the high load.
>
> I'm running Linux 2.6.26-rc2 (not newer due to the slowdown problem
> introduced by commit
> 8d30c14cab30d405a05f2aaceda1e9ad57800f36, as pointed out by Rex Feany
> this week), and
> glibc v2.6 (part of ELDK 4.2).
>
> Is this a problem due to an error in the futex implementation in
> glibc, or a kernel problem?
>
> Best regards,
> Frank
>
