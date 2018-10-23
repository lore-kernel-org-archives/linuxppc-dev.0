Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB62C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 11:02:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EAD20665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 11:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yzp4Avzm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bYaIm7G2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EAD20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fVpJ3jjvzF37r
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 22:02:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yzp4Avzm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bYaIm7G2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=arunks@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="Yzp4Avzm"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="bYaIm7G2"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fS9r0w46zDsFP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 20:03:59 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 12E4D613FC; Tue, 23 Oct 2018 04:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1540270116;
 bh=dtzAW1nZDtsAh1MSgdkacD9E0lJhfSZAkRN995N8TJs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Yzp4AvzmfxApod3AvVMRM9/VSvwtME16rSo6QmUummsmDMZ5JXUdFRnR/pn1cfwpP
 wXb1CATSCl8d3P5BXWuyMnQRVMC5aPsoSybu1NLTHZEUJJajEwG4bNAvSUAJ09tocW
 SfWRULiwCiyYC7gxhEFdbw0zFt1VaExM86o6Z6h0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 by smtp.codeaurora.org (Postfix) with ESMTP id 0DF6860C5F;
 Tue, 23 Oct 2018 04:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1540270107;
 bh=dtzAW1nZDtsAh1MSgdkacD9E0lJhfSZAkRN995N8TJs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bYaIm7G2OcCCJDBLW816Q8kMAVBokurTBwfOwmr1X/S16VklSCI+ZgBE1vofXkvlS
 /QTiMltOO8jrM0JrbIvtHC1ak5np5htf4+Hwn33cUITjbMSUQs/8eYtsTDeby1TC9C
 JRCmlPL55Lt442tTy1LcTmJ9LW9Y5VccKI1oH15k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 23 Oct 2018 10:18:26 +0530
From: Arun KS <arunks@codeaurora.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
In-Reply-To: <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
Message-ID: <92d3523427e45124c71e16baabceb8c5@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
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
Cc: Mike Snitzer <snitzer@redhat.com>, Kemi Wang <kemi.wang@intel.com>,
 dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>,
 linux-sctp@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>, Christoph Lameter <cl@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Petr Tesarik <ptesarik@suse.com>, ceph-devel@vger.kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com,
 Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
 "Steven J. Hill" <steven.hill@cavium.com>,
 David Rientjes <rientjes@google.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Daniel Vacek <neelx@redhat.com>,
 Roman Gushchin <guro@fb.com>, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 linux-um@lists.infradead.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anton Altaparmakov <anton@tuxera.com>, linux-parisc@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Cyril Bur <cyrilbur@gmail.com>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 netfilter-devel@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 David Airlie <airlied@linux.ie>, dm-devel@redhat.com,
 Nadav Amit <namit@vmware.com>, Omar Sandoval <osandov@fb.com>,
 Alasdair Kergon <agk@redhat.com>, linux-s390@vger.kernel.org,
 Stephen Hemminger <sthemmin@microsoft.com>, intel-gfx@lists.freedesktop.org,
 Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>, "Luis R.
 Rodriguez" <mcgrof@kernel.org>, coreteam@netfilter.org,
 Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-media@vger.kernel.org,
 YueHaibing <yuehaibing@huawei.com>, Todd Kjos <tkjos@android.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Jia He <jia.he@hxt-semitech.com>,
 Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Houlong Wei <houlong.wei@mediatek.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Martijn Coenen <maco@android.com>, linux-arm-kernel@lists.infradead.org,
 Khalid Aziz <khalid@gonehiking.org>, Oded Gabbay <oded.gabbay@gmail.com>,
 linaro-mm-sig@lists.linaro.org, linux-ntfs-dev@lists.sourceforge.net,
 Jonathan Corbet <corbet@lwn.net>, Florian Westphal <fw@strlen.de>,
 Anna Schumaker <anna.schumaker@netapp.com>, Pekka Enberg <penberg@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 linux-fsdevel@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Agner <stefan@agner.ch>,
 James Morris <jmorris@namei.org>, netdev@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Jan Kara <jack@suse.cz>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Gerrit Renker <gerrit@erg.abdn.ac.uk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
 Matthew Auld <matthew.auld@intel.com>, Guo Ren <ren_guo@c-sky.com>,
 Huang Ying <ying.huang@intel.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Ilya Dryomov <idryomov@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Haiyang Zhang <haiyangz@microsoft.com>, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Dan Streetman <ddstreet@ieee.org>,
 Oscar Salvador <osalvador@suse.de>, linux-nfs@vger.kernel.org,
 Neil Horman <nhorman@tuxdriver.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Jeff Layton <jlayton@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jessica Yu <jeyu@kernel.org>, devel@linuxdriverproject.org,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "VMware, 
 Inc." <pv-drivers@vmware.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org,
 Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, getarunks@gmail.com,
 Chintan Pandya <cpandya@codeaurora.org>, devel@driverdev.osuosl.org, "Yan,
 Zheng" <zyan@redhat.com>, xen-devel@lists.xenproject.org,
 Sage Weil <sage@redhat.com>, dccp@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Seth Jennings <sjenning@redhat.com>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Laura Abbott <labbott@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Jann Horn <jannh@google.com>, Xavier Deguillard <xdeguillard@vmware.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?J=C3=A9r?= =?UTF-8?Q?=C3=B4me_Glisse?= <jglisse@redhat.com>,
 Kirill Tkhai <ktkhai@virtuozzo.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-integrity@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>,
 Yang Shi <yang.shi@linux.alibaba.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, linuxppc-dev@lists.ozlabs.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-decnet-user@lists.sourceforge.net,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 Mel Gorman <mgorman@techsingularity.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2018-10-23 09:45, Joe Perches wrote:
> On Mon, 2018-10-22 at 22:53 +0530, Arun KS wrote:
>> Remove managed_page_count_lock spinlock and instead use atomic
>> variables.
> 

Hello Joe,
> Perhaps better to define and use macros for the accesses
> instead of specific uses of atomic_long_<inc/dec/read>
> 
> Something like:
> 
> #define totalram_pages()	(unsigned 
> long)atomic_long_read(&_totalram_pages)
> #define totalram_pages_inc()	(unsigned 
> long)atomic_long_inc(&_totalram_pages)
> #define totalram_pages_dec()	(unsigned 
> long)atomic_long_dec(&_totalram_pages)

That sounds like a nice idea.

Regards,
Arun
