Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD8C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 10:58:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5699920665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 10:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkwiM0ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5699920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fVjT0F4YzF36n
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 21:58:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dkwiM0ks";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::b44; helo=mail-yb1-xb44.google.com;
 envelope-from=getarunks@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dkwiM0ks"; 
 dkim-atps=neutral
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fLTT6NZczDrpw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 15:47:06 +1100 (AEDT)
Received: by mail-yb1-xb44.google.com with SMTP id n140-v6so30926yba.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 21:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TlO+0k0SfBCasUX3r7X/bJP9P1ED24TAjIuARBv6nck=;
 b=dkwiM0ksWYqCCVIo+vWjiu86bPCXgnsVPRGIu0AmEooJ2evzojdi5JorLfNUJdHhp7
 CmupJ2bF4/bOgtbkD/56WbYT4g3EVcfSKdXFZ8X7RA9ujsFL61NK0v8Y6qKnSG/gwjzW
 WStbnawYjSkYPldg13qgiH223ht4tT8G/q1WqfFVUG+cXjE+uIs0xrysOuiyLDUcxEvQ
 bjvax2jkVraIx8xGS8J4VgTdqwObcn+jyOMZl3xN9we8EoPcWe60s4FSUInT2P+anmp8
 X7KsbMYwx64MCVbMalKXdOYvRkQKK0+Ro+oMh37CCSMQ7rSn5DMdu/oy+wYFhBRDtddc
 LObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TlO+0k0SfBCasUX3r7X/bJP9P1ED24TAjIuARBv6nck=;
 b=HEil9yTypwXssa08fIR9XGXFewz4Or4X2+95O1m0xR6BcYoNl1FLq7jhcxMRKnQbjR
 bz+9Cggcft+wK7PExPyrDRl3zvr4OiuHxkyQ01albW5cOZFteoQeBlmAOEE5I6b6lW1V
 +KiWga2lmGSVwovOCiRUaC7OzdpayPpCrHYmLoTQQpQl9N/FUEAzBkwR7Dn/9aefGXmQ
 nk4w7XA5ddBIy/hOonvbhyP+T/HBp1bObn7M+A0PADQcJi06VvJNuqiXP6BF34S0mZ4d
 KZV/9Tq+vWlwj+7JsI63MbJTyz3QyOE//yFG3JGbI1NzsYf0bH/AK+QnASgZa5ug+aFi
 TJHQ==
X-Gm-Message-State: ABuFfohqhrWcwHvWCv2u8306zebhBTeg9J2f64RnfpeFXBTaKa8VQQuf
 pRV4KyGnIJkw9JbxbSwccGUwMzsdifvHs4gnXaQ=
X-Google-Smtp-Source: ACcGV61Aok09sZz1VwmhdTA4yM5aQzDOHnnx8/Sdb5oIExzMWUZAnD1LfCF26d9FwKzbFomdjWPs15GkA+qnFxkVuRs=
X-Received: by 2002:a25:3c7:: with SMTP id
 190-v6mr34473821ybd.457.1540270023614; 
 Mon, 22 Oct 2018 21:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <20181022181122.GK18839@dhcp22.suse.cz>
In-Reply-To: <20181022181122.GK18839@dhcp22.suse.cz>
From: Arun Sudhilal <getarunks@gmail.com>
Date: Tue, 23 Oct 2018 10:16:51 +0530
Message-ID: <CABOM9Zpq41Ox8wQvsNjgfCtwuqh6CnyeW1B09DWa1TQN+JKf0w@mail.gmail.com>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
To: mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 23 Oct 2018 21:48:35 +1100
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
Cc: snitzer@redhat.com, kemi.wang@intel.com, dri-devel@lists.freedesktop.org,
 bfields@fieldses.org, linux-sctp@vger.kernel.org, paulus@samba.org,
 pavel@ucw.cz, cl@linux.com, kys@microsoft.com, sumit.semwal@linaro.org,
 David1.Zhou@amd.com, ptesarik@suse.com, ceph-devel@vger.kernel.org,
 jejb@parisc-linux.org, kasan-dev@googlegroups.com, marcos.souza.org@gmail.com,
 steven.hill@cavium.com, rientjes@google.com, anthony.yznaga@oracle.com,
 neelx@redhat.com, guro@fb.com, len.brown@intel.com, linux-pm@vger.kernel.org,
 vbabka@suse.cz, linux-um@lists.infradead.org, rppt@linux.vnet.ibm.com,
 viro@zeniv.linux.org.uk, tglx@linutronix.de, trond.myklebust@hammerspace.com,
 anton@tuxera.com, linux-parisc@vger.kernel.org, malat@debian.org,
 gregkh@linuxfoundation.org, rdunlap@infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, cyrilbur@gmail.com, arve@android.com,
 netfilter-devel@vger.kernel.org, jrdr.linux@gmail.com,
 dmitry.kasatkin@gmail.com, alexander.deucher@amd.com, arunks@codeaurora.org,
 Andrew Morton <akpm@linux-foundation.org>, andrew-ct.chen@mediatek.com,
 gustavo@embeddedor.com, airlied@linux.ie, dm-devel@redhat.com,
 namit@vmware.com, osandov@fb.com, agk@redhat.com, linux-s390@vger.kernel.org,
 sthemmin@microsoft.com, intel-gfx@lists.freedesktop.org, deller@gmx.de,
 hughd@google.com, mcgrof@kernel.org, coreteam@netfilter.org,
 kadlec@blackhole.kfki.hu, aryabinin@virtuozzo.com, linux-media@vger.kernel.org,
 yuehaibing@huawei.com, tkjos@android.com, pombredanne@nexb.com,
 jani.nikula@linux.intel.com, jia.he@hxt-semitech.com,
 Tejun Heo <tj@kernel.org>, shakeelb@google.com, houlong.wei@mediatek.com,
 devel@linuxdriverproject.org, boris.ostrovsky@oracle.com, maco@android.com,
 linux-arm-kernel@lists.infradead.org, khalid@gonehiking.org,
 oded.gabbay@gmail.com, linaro-mm-sig@lists.linaro.org,
 linux-ntfs-dev@lists.sourceforge.net, corbet@lwn.net, fw@strlen.de,
 anna.schumaker@netapp.com, penberg@kernel.org, minchan@kernel.org,
 ebiederm@xmission.com, aneesh.kumar@linux.ibm.com, schwidefsky@de.ibm.com,
 iamjoonsoo.kim@lge.com, kstewart@linuxfoundation.org,
 marcelo.leitner@gmail.com, linux-fsdevel@vger.kernel.org,
 penguin-kernel@i-love.sakura.ne.jp, joonas.lahtinen@linux.intel.com,
 heiko.carstens@de.ibm.com, stefan@agner.ch, jmorris@namei.org,
 netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org, jack@suse.cz,
 alexander.h.duyck@linux.intel.com, gerrit@erg.abdn.ac.uk,
 andriy.shevchenko@linux.intel.com, miklos@szeredi.hu, david@redhat.com,
 willy@infradead.org, khlebnikov@yandex-team.ru, matthew.auld@intel.com,
 ren_guo@c-sky.com, ying.huang@intel.com, kuznet@ms2.inr.ac.ru,
 idryomov@gmail.com, adobriyan@gmail.com, pablo@netfilter.org, serge@hallyn.com,
 keescook@chromium.org, arnd@arndb.de, haiyangz@microsoft.com,
 broonie@kernel.org, bp@alien8.de, rodrigo.vivi@intel.com,
 dan.j.williams@intel.com, mchehab@kernel.org, ddstreet@ieee.org,
 osalvador@suse.de, linux-nfs@vger.kernel.org, nhorman@tuxdriver.com,
 tvrtko.ursulin@intel.com, jlayton@kernel.org, edumazet@google.com,
 jeyu@kernel.org, joe@perches.com, davem@davemloft.net,
 kirill.shutemov@linux.intel.com, minghsiu.tsai@mediatek.com,
 christian.koenig@amd.com, pv-drivers@vmware.com, bigeasy@linutronix.de,
 chris@chris-wilson.co.uk, linux-mm@kvack.org, glider@google.com, hpa@zytor.com,
 cpandya@codeaurora.org, devel@driverdev.osuosl.org, zyan@redhat.com,
 xen-devel@lists.xenproject.org, sage@redhat.com, dccp@vger.kernel.org,
 richard@nod.at, sjenning@redhat.com, x86@kernel.org, mingo@redhat.com,
 labbott@redhat.com, zohar@linux.vnet.ibm.com, jdike@addtoit.com,
 pavel.tatashin@microsoft.com, jannh@google.com, xdeguillard@vmware.com,
 hannes@cmpxchg.org, jglisse@redhat.com, ktkhai@virtuozzo.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 tiffany.lin@mediatek.com, linux-integrity@vger.kernel.org, dvyukov@google.com,
 jgross@suse.com, yang.shi@linux.alibaba.com, yoshfuji@linux-ipv6.org,
 linuxppc-dev@lists.ozlabs.org, vyasevich@gmail.com,
 linux-decnet-user@lists.sourceforge.net, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, tzimmermann@suse.de,
 mika.kuoppala@linux.intel.com, mgorman@techsingularity.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 22, 2018 at 11:41 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 22-10-18 22:53:22, Arun KS wrote:
> > Remove managed_page_count_lock spinlock and instead use atomic
> > variables.
>

Hello Michal,
> I assume this has been auto-generated. If yes, it would be better to
> mention the script so that people can review it and regenerate for
> comparision. Such a large change is hard to review manually.

Changes were made partially with script.  For totalram_pages and
totalhigh_pages,

find dir -type f -exec sed -i
's/totalram_pages/atomic_long_read(\&totalram_pages)/g' {} \;
find dir -type f -exec sed -i
's/totalhigh_pages/atomic_long_read(\&totalhigh_pages)/g' {} \;

For managed_pages it was mostly manual edits after using,
find mm/ -type f -exec sed -i
's/zone->managed_pages/atomic_long_read(\&zone->managed_pages)/g' {}
\;

Regards,
Arun

> --
> Michal Hocko
> SUSE Labs
