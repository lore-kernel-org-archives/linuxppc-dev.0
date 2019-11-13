Return-Path: <SRS0=PO5t=ZF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821F4C17449
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 10:12:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012442245B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 10:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012442245B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47CgQb3V1BzF7dV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 21:12:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.135; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47CgMN4GHLzF5Yx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2019 21:09:36 +1100 (AEDT)
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N8GIa-1hr2n63zw8-014CjT for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov
 2019 11:04:21 +0100
Received: by mail-qk1-f181.google.com with SMTP id m16so1151856qki.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2019 02:04:20 -0800 (PST)
X-Gm-Message-State: APjAAAWh50hkT1qQjYGORWqkJqfzFTjjvsn7GWJ0Sm2JnP856zOVyxuR
 aQgDtR0br2MWrTvWxO1zfKrHPA3KCNbLowxRxmA=
X-Google-Smtp-Source: APXvYqz76N6YiMmMuv8QGr8pQBLKX8fP4b2vDDkNDidONegs5IwTjLmxR7A3gx/rfbjKvqliI9W4OwftLepJpjq9AAU=
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr1708504qke.352.1573639459115; 
 Wed, 13 Nov 2019 02:04:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573576649.git.msuchanek@suse.de>
 <13fa324dc879a7f325290bf2e131b87eb491cd7b.1573576649.git.msuchanek@suse.de>
 <1573613683.ylw9dz9mlc.astroid@bobo.none>
 <20191113084137.GI2770@kitsune.suse.cz>
In-Reply-To: <20191113084137.GI2770@kitsune.suse.cz>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Nov 2019 11:04:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ikEMP6MQzL8QPMTgdA-euf7_AsFZAbxkDbFh=smMuaQ@mail.gmail.com>
Message-ID: <CAK8P3a0ikEMP6MQzL8QPMTgdA-euf7_AsFZAbxkDbFh=smMuaQ@mail.gmail.com>
Subject: Re: [PATCH 31/33] powerpc/64: make buildable without CONFIG_COMPAT
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:43+0uyZBPfcUA3E30MyL/ZPlP7kJLLkZZO1HsA4rtJXCixVgrz/
 2/Z50qoDz3hm75fEVU18PUnxdfxasrgqsYLEQEXU/O9IABNFNmZkqpjHTrs1E6Tceitr8WM
 Be0hwqdSahJjGhaIW2bDACPKY5njPgJVXTyxBJoGaIf+5xe2i+YgM/P99NqjLvtdZ7gxsC6
 HwnENjqH6gETbrIKPxlvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wiOCp9kSsBM=:FSv/i4HpLqt6V8ptNwh9SA
 TluhTsPDL0dM0Gi+Rai2GUVRNWA7Pa8gCfwtEyz5WMeTgNiYQ5bZMdEaPMFkT3s1qldreb5Tt
 KzWzzke4wysssFVKfPWGJ48j/vC5bdLNsjsBvtT2+mjj9m3I/fdSWyrUqmSgRTT+rh8K1RSQF
 MtKSyxpMPS0F2MdnjK2EWGElyx8SQFOGwfii/jbSIVaXsXt4y1EPixwGTK04OZPeCTTkk4XtB
 W4TQ/n/jTPOdU0jAAeKRswCI5eFWQch/b1ud/hQ1BX8bg+5dD2DCM62z/ZhMQcl2pBgc41Y7N
 AKuZSKo8Gq2H1qRUW1i4kQMxmx2kWIcyTSBR0yHkLtKRqlIXiwpN0oNim2ku517oJOWkDxR2O
 12fCgDVO9d3pywrltFYuF5OTcpJtoxzht5YFObsrgqLs2zwCd1I9pnkz2GVrsKFh8CCjuSoK7
 qLUavPf2H5bWwN/jmJbIGFmGLztL6v0wgdLxj6oUxXRqjWbSMdFOEbyFnHzTSYK8vjbVpL+eD
 s3NAI85qmk/Ydhao8fARXcR0YwldfgSoENrHpTfp9uN+gYdws/p/OHX1IHeFi3LJfcUoK9jWv
 viBLDZR2zWvNAr5uhQx28zDKvJGASPr79xm4TIpPVSBpSAWv6KFWcdSBHMESheWyxKqndaDu+
 aQY4RSDTyZfHgsVMuBhlr65uTiaHDj6DcVV+oGZAQcDtiE/+YK1tGfd5ZdUyeSfOXTN+NlOpp
 ZXDZaq7Kqty7she6BurunrMQCHkLZ+bkwTPEZi/VpgT/OuQF8ZJGRh9mlcmQR+dp6IBmEsSk2
 HjkM6R2rCvwNUQwMmdAvueEYJr+5Zvqh+uixCtqd3FnwE/4mxbw77TF1C6SDj88rwYpEWx50l
 /r/ULjnfgHKFdoDbiY+Dye84KMP3glUGRkVC09WleKPvy5j28UmWMs1i8Ggn9r6bNFL11NRcW
 BOjcciPJ8xO6p4/i+h1GtrMZxbwIqaaLcm1dYsVKOUKZ+z0lXcz0h4SP2jnBEry/C+LU+K09P
 IAUzcf7T4KuCvwHYVEkwVutmwWPRQUMZXg1YGh72DUCR
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>, Breno Leitao <leitao@debian.org>,
 Michael Neuling <mikey@neuling.org>, Allison Randal <allison@lohutok.net>,
 Diana Craciun <diana.craciun@nxp.com>, Firoz Khan <firoz.khan@linaro.org>,
 Christian Brauner <christian@brauner.io>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Jagadeesh Pagadala <jagdsh.linux@gmail.com>, Nicolai Stange <nstange@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Hari Bathini <hbathini@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Gustavo Romero <gromero@linux.ibm.com>, Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 13, 2019 at 9:41 AM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
>
> On Wed, Nov 13, 2019 at 01:02:34PM +1000, Nicholas Piggin wrote:

> > >
> > > @@ -277,7 +276,7 @@ static void do_signal(struct task_struct *tsk)
> > >
> > >     rseq_signal_deliver(&ksig, tsk->thread.regs);
> > >
> > > -   if (is32) {
> > > +   if (is_32bit_task()) {
> > >             if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> > >                     ret =3D handle_rt_signal32(&ksig, oldset, tsk);
> > >             else
> >
> > This is just a clean up I guess.
>
> It also expands directly to if(0) or if(1) for the !COMPAT cases. I am
> not sure how it would work with the intermediate variable.
>
> There was more complex change initially but after some additional
> cleanups removing the variable is the only part left.

I would be surprised if that made any difference to a modern compiler,
but the new version is definitely clearer to human readers.

       Arnd
