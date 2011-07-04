Return-Path: <akinobu.mita@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A94C6B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 15:35:08 +1000 (EST)
Received: by vws20 with SMTP id 20so3834114vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 03 Jul 2011 22:35:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110703171626.GG21127@elf.ucw.cz>
References: <1309702581-16863-1-git-send-email-akinobu.mita@gmail.com>
	<1309702581-16863-4-git-send-email-akinobu.mita@gmail.com>
	<20110703171626.GG21127@elf.ucw.cz>
Date: Mon, 4 Jul 2011 14:35:04 +0900
Message-ID: <CAC5umyhKafTgUe6T2vfLupwmBwt5COj6X2nUH2b5ekhzQNi5mg@mail.gmail.com>
Subject: Re: [PATCH 3/7] fault-injection: notifier error injection
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-mm@kvack.org,
	Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/7/4 Pavel Machek <pavel@ucw.cz>:
>
>> + =A0 =A0 for (action =3D enb->actions; action->name; action++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct dentry *file =3D debugfs_create_int(act=
ion->name, mode,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 enb->dir, &action->error);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!file) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 debugfs_remove_recursive(enb->=
dir);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Few lines how this work would be welcome...?

OK, I'll add a comment like below.

/*
 * Create debugfs r/w file containing action->error. If notifier call
 * chain is called with action->val, it will fail with the error code
 */
