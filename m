Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0328CC46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 10:59:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8220120665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 10:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8220120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fVlW3Sj3zF36n
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 21:59:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=ying.huang@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fMbf6FH9zDrbV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 16:37:30 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2018 22:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,414,1534834800"; d="scan'208";a="99849695"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
 by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2018 22:37:02 -0700
From: "Huang\, Ying" <ying.huang@intel.com>
To: Arun KS <arunks@codeaurora.org>
Subject: Re: [PATCH] mm: convert totalram_pages,
 totalhigh_pages and managed_pages to atomic.
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
Date: Tue, 23 Oct 2018 13:37:01 +0800
In-Reply-To: <1540229092-25207-1-git-send-email-arunks@codeaurora.org> (Arun
 KS's message of "Mon, 22 Oct 2018 22:53:22 +0530")
Message-ID: <874lddxlz6.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
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
 Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
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
 Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, coreteam@netfilter.org,
 Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-media@vger.kernel.org,
 YueHaibing <yuehaibing@huawei.com>, Todd Kjos <tkjos@android.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Jia He <jia.he@hxt-semitech.com>,
 Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Houlong Wei <houlong.wei@mediatek.com>, devel@linuxdriverproject.org,
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
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
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
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ilya Dryomov <idryomov@gmail.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Dan Streetman <ddstreet@ieee.org>,
 Oscar Salvador <osalvador@suse.de>, linux-nfs@vger.kernel.org,
 Neil Horman <nhorman@tuxdriver.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Jeff Layton <jlayton@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jessica Yu <jeyu@kernel.org>, Joe Perches <joe@perches.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, "VMware,
 Inc." <pv-drivers@vmware.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org,
 Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 getarunks@gmail.com, Chintan Pandya <cpandya@codeaurora.org>,
 devel@driverdev.osuosl.org, "Yan, Zheng" <zyan@redhat.com>,
 xen-devel@lists.xenproject.org, Sage Weil <sage@redhat.com>,
 dccp@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Seth Jennings <sjenning@redhat.com>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>, Jann Horn <jannh@google.com>,
 Xavier Deguillard <xdeguillard@vmware.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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

Arun KS <arunks@codeaurora.org> writes:

> Remove managed_page_count_lock spinlock and instead use atomic
> variables.
>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Arun KS <arunks@codeaurora.org>
>
> ---
> As discussed here,
> https://patchwork.kernel.org/patch/10627521/#22261253

My 2 cents.  I think you should include at least part of the discussion
in the patch description to make it more readable by itself.

Best Regards,
Huang, Ying
