Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372FFC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 11:13:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2095820659
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 11:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2095820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431YZT07VRzDqZQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 22:13:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=vl18780.dinaserver.com (client-ip=82.98.188.50;
 helo=vl18780.dinaserver.com; envelope-from=root@vl18780.dinaserver.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-sky.com
X-Greylist: delayed 471 seconds by postgrey-1.36 at bilbo;
 Fri, 23 Nov 2018 20:01:47 AEDT
Received: from vl18780.dinaserver.com (vl18780.dinaserver.com [82.98.188.50])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431Vfz2NJ6zDqVv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 20:01:45 +1100 (AEDT)
X-DinaScanner-From: root@vl18780.dinaserver.com
X-DinaScanner-SpamCheck: no es spam, SpamAssassin (almacenado,
 puntaje=-0.496, requerido 6, autolearn=disabled, BAYES_00 -0.50,
 FROM_IS_NOT_RETURN_PATH 1.00, HEADER_FROM_DIFFERENT_DOMAINS 0.00,
 MAILING_LIST_MULTI -1.00, RELAY_CN 0.00, RELAY_US 0.00,
 UNPARSEABLE_RELAY 0.00)
X-DinaScanner-SpamVirus-Report: ScamNailer.Phish.viro_AT_zeniv.linux.org.uk.UNOFFICIAL
X-DinaScanner: Libre de Virus
X-DinaScanner-ID: A21DA1F6836.A9D89
X-DinaScanner-Information: DinaScanner. Filtro anti-Spam y anti-Virus
Received: by vl18780.dinaserver.com (Postfix, from userid 0)
 id A21DA1F6836; Fri, 23 Nov 2018 09:53:01 +0100 (CET)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by vl18780.dinaserver.com (Postfix) with ESMTPS id BE3C11F6C4D
 for <javiermartin@by.com.es>; Fri, 23 Nov 2018 08:42:17 +0100 (CET)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5D0596E48A;
 Fri, 23 Nov 2018 07:42:08 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Thu, 22 Nov 2018 01:38:43 UTC
Received: from smtp2200-217.mail.aliyun.com (smtp2200-217.mail.aliyun.com
 [121.197.200.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B446E2D2;
 Thu, 22 Nov 2018 01:38:43 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0765762|-1; CH=green;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03293; MF=ren_guo@c-sky.com; NM=1; PH=DS; RN=178;
 RT=178; SR=0; TI=SMTPD_---.DMJpVtu_1542850400; 
Received: from localhost(mailfrom:ren_guo@c-sky.com
 fp:SMTPD_---.DMJpVtu_1542850400)
 by smtp.aliyun-inc.com(10.147.41.158);
 Thu, 22 Nov 2018 09:33:22 +0800
Date: Thu, 22 Nov 2018 09:33:10 +0800
From: Guo Ren <ren_guo@c-sky.com>
To: Arun KS <arunks@codeaurora.org>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
Message-ID: <20181122013310.GA20480@guoren-Inspiron-7460>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
X-Mailman-Approved-At: Fri, 23 Nov 2018 07:41:29 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Fri, 23 Nov 2018 22:10:55 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mike Snitzer <snitzer@redhat.com>, Hugh Dickins <hughd@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Jeff Dike <jdike@addtoit.com>,
 dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>,
 linux-sctp@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>, Christoph Lameter <cl@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Petr Tesarik <ptesarik@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 James Morris <jmorris@namei.org>, kasan-dev@googlegroups.com,
 Joe Perches <joe@perches.com>,
 Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
 "Steven J. Hill" <steven.hill@cavium.com>,
 David Rientjes <rientjes@google.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Daniel Vacek <neelx@redhat.com>,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 linux-um@lists.infradead.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anton Altaparmakov <anton@tuxera.com>, Neil Horman <nhorman@tuxdriver.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 netfilter-devel@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 David Airlie <airlied@linux.ie>, Jeff Layton <jlayton@kernel.org>,
 dm-devel@redhat.com, Nadav Amit <namit@vmware.com>,
 Alex Deucher <alexander.deucher@amd.com>, Omar Sandoval <osandov@fb.com>,
 Alasdair Kergon <agk@redhat.com>, linux-s390@vger.kernel.org,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
 YueHaibing <yuehaibing@huawei.com>,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, coreteam@netfilter.org,
 Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-media@vger.kernel.org,
 Todd Kjos <tkjos@android.com>, Jessica Yu <jeyu@kernel.org>,
 Houlong Wei <houlong.wei@mediatek.com>, Jia He <jia.he@hxt-semitech.com>,
 Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Martijn Coenen <maco@android.com>, linux-arm-kernel@lists.infradead.org,
 Khalid Aziz <khalid@gonehiking.org>, linaro-mm-sig@lists.linaro.org,
 linux-ntfs-dev@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>,
 Florian Westphal <fw@strlen.de>, Roman Gushchin <guro@fb.com>,
 Pekka Enberg <penberg@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Matthew Wilcox <willy@infradead.org>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Gerrit Renker <gerrit@erg.abdn.ac.uk>, Tiffany Lin <tiffany.lin@mediatek.com>,
 Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 amd-gfx@lists.freedesktop.org,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Matthew Auld <matthew.auld@intel.com>, Huang Ying <ying.huang@intel.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ilya Dryomov <idryomov@gmail.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
 Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Kemi Wang <kemi.wang@intel.com>, ceph-devel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Dan Streetman <ddstreet@ieee.org>,
 Oscar Salvador <osalvador@suse.de>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>, linux-nfs@vger.kernel.org,
 linux-parisc@vger.kernel.org, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Eric Dumazet <edumazet@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Dmitry Vyukov <dvyukov@google.com>,
 devel@linuxdriverproject.org, Anna Schumaker <anna.schumaker@netapp.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
 Alexander Potapenko <glider@google.com>, getarunks@gmail.com,
 Chintan Pandya <cpandya@codeaurora.org>, devel@driverdev.osuosl.org, "Yan,
 Zheng" <zyan@redhat.com>, xen-devel@lists.xenproject.org,
 Sage Weil <sage@redhat.com>, dccp@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Seth Jennings <sjenning@redhat.com>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Cyril Bur <cyrilbur@gmail.com>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>, Jann Horn <jannh@google.com>,
 Xavier Deguillard <xdeguillard@vmware.com>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Kirill Tkhai <ktkhai@virtuozzo.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-integrity@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Juergen Gross <jgross@suse.com>, "VMware, 
 Inc." <pv-drivers@vmware.com>, Yang Shi <yang.shi@linux.alibaba.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-decnet-user@lists.sourceforge.net,
 kexec@lists.infradead.org, Mel Gorman <mgorman@techsingularity.net>,
 linux-security-module@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20181122013310.IuKTJGBQ21ioNT_kX6QPzbHnHA0ZLd4poIDmkf7szLE@z>

T24gTW9uLCBPY3QgMjIsIDIwMTggYXQgMTA6NTM6MjJQTSArMDUzMCwgQXJ1biBLUyB3cm90ZToK
PiBSZW1vdmUgbWFuYWdlZF9wYWdlX2NvdW50X2xvY2sgc3BpbmxvY2sgYW5kIGluc3RlYWQgdXNl
IGF0b21pYwo+IHZhcmlhYmxlcy4KPiAKPiBTdWdnZXN0ZWQtYnk6IE1pY2hhbCBIb2NrbyA8bWhv
Y2tvQHN1c2UuY29tPgo+IFN1Z2dlc3RlZC1ieTogVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3Vz
ZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBBcnVuIEtTIDxhcnVua3NAY29kZWF1cm9yYS5vcmc+Cj4g
Cj4gLS0tCj4gQXMgZGlzY3Vzc2VkIGhlcmUsCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wYXRjaC8xMDYyNzUyMS8jMjIyNjEyNTMKPiAtLS0KPiAtLS0KPiAgYXJjaC9jc2t5L21tL2lu
aXQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0KPiAgYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wc2VyaWVzL2NtbS5jICAgICAgICAgIHwgMTEgKystLQo+ICBhcmNoL3MzOTAvbW0v
aW5pdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBhcmNoL3VtL2tlcm5l
bC9tZW0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArLQo+ICBhcmNoL3g4Ni9rZXJu
ZWwvY3B1L21pY3JvY29kZS9jb3JlLmMgICAgICAgICAgfCAgNSArLQo+ICBkcml2ZXJzL2NoYXIv
YWdwL2JhY2tlbmQuYyAgICAgICAgICAgICAgICAgICAgfCAgNCArLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJzL2dwdS9k
cm0vaTkxNS9pOTE1X2dlbS5jICAgICAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJzL2dwdS9k
cm0vaTkxNS9zZWxmdGVzdHMvaTkxNV9nZW1fZ3R0LmMgfCAgNCArLQo+ICBkcml2ZXJzL2h2L2h2
X2JhbGxvb24uYyAgICAgICAgICAgICAgICAgICAgICAgfCAxOSArKystLS0tCj4gIGRyaXZlcnMv
bWQvZG0tYnVmaW8uYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICstCj4gIGRyaXZlcnMv
bWQvZG0tY3J5cHQuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstCj4gIGRyaXZlcnMv
bWQvZG0taW50ZWdyaXR5LmMgICAgICAgICAgICAgICAgICAgICB8ICA0ICstCj4gIGRyaXZlcnMv
bWQvZG0tc3RhdHMuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstCj4gIGRyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbXRrLXZwdS9tdGtfdnB1LmMgICAgICB8ICAzICstCj4gIGRyaXZlcnMv
bWlzYy92bXdfYmFsbG9vbi5jICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIGRyaXZlcnMv
cGFyaXNjL2NjaW8tZG1hLmMgICAgICAgICAgICAgICAgICAgICB8ICA1ICstCj4gIGRyaXZlcnMv
cGFyaXNjL3NiYV9pb21tdS5jICAgICAgICAgICAgICAgICAgICB8ICA1ICstCj4gIGRyaXZlcnMv
c3RhZ2luZy9hbmRyb2lkL2lvbi9pb25fc3lzdGVtX2hlYXAuYyB8ICAyICstCj4gIGRyaXZlcnMv
eGVuL3hlbi1zZWxmYmFsbG9vbi5jICAgICAgICAgICAgICAgICB8ICA3ICstLQo+ICBmcy9jZXBo
L3N1cGVyLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArLQo+ICBmcy9maWxl
X3RhYmxlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgOSArKy0tCj4gIGZzL2Z1
c2UvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstCj4gIGZzL25m
cy93cml0ZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstCj4gIGZzL25m
c2QvbmZzY2FjaGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstCj4gIGZzL250
ZnMvbWFsbG9jLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIGZzL3By
b2MvYmFzZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstCj4gIGluY2x1
ZGUvbGludXgvaGlnaG1lbS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIGluY2x1
ZGUvbGludXgvbW0uaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIGluY2x1
ZGUvbGludXgvbW16b25lLmggICAgICAgICAgICAgICAgICAgICAgICB8IDEwICstLS0KPiAgaW5j
bHVkZS9saW51eC9zd2FwLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAga2Vy
bmVsL2ZvcmsuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKy0tCj4gIGtl
cm5lbC9rZXhlY19jb3JlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICstCj4gIGtl
cm5lbC9wb3dlci9zbmFwc2hvdC5jICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIGxp
Yi9zaG93X21lbS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstCj4gIG1t
L2hpZ2htZW0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIG1t
L2h1Z2VfbWVtb3J5LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIG1t
L2thc2FuL3F1YXJhbnRpbmUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstCj4gIG1t
L21lbWJsb2NrLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICstLQo+ICBt
bS9tZW1vcnlfaG90cGx1Zy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArLQo+ICBt
bS9tbV9pbml0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArLQo+ICBt
bS9vb21fa2lsbC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBt
bS9wYWdlX2FsbG9jLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA3NSArKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0KPiAgbW0vc2htZW0uYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTIgKysrLS0KPiAgbW0vc2xhYi5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDMgKy0KPiAgbW0vc3dhcC5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDMgKy0KPiAgbW0vdXRpbC5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgbW0vdm1hbGxvYy5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDQgKy0KPiAgbW0vdm1zdGF0LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDQgKy0KPiAgbW0vd29ya2luZ3NldC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgbW0venN3YXAuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgbmV0L2RjY3AvcHJvdG8uYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDYgKy0tCj4gIG5ldC9kZWNuZXQvZG5fcm91dGUuYyAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAyICstCj4gIG5ldC9pcHY0L3RjcF9tZXRyaWNzLmMgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAyICstCj4gIG5ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2Nv
cmUuYyAgICAgICAgICAgICB8ICA2ICstLQo+ICBuZXQvbmV0ZmlsdGVyL3h0X2hhc2hsaW1pdC5j
ICAgICAgICAgICAgICAgICAgfCAgNCArLQo+ICBuZXQvc2N0cC9wcm90b2NvbC5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNiArLS0KPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFf
a2V4ZWMuYyAgICAgICAgICAgIHwgIDIgKy0KPiAgNTggZmlsZXMgY2hhbmdlZCwgMTcxIGluc2Vy
dGlvbnMoKyksIDE0MyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9jc2t5L21t
L2luaXQuYyBiL2FyY2gvY3NreS9tbS9pbml0LmMKPiBpbmRleCBkYzA3YzA3Li4zZjRkMzVlIDEw
MDY0NAo+IC0tLSBhL2FyY2gvY3NreS9tbS9pbml0LmMKPiArKysgYi9hcmNoL2Nza3kvbW0vaW5p
dC5jCj4gQEAgLTcxLDcgKzcxLDcgQEAgdm9pZCBmcmVlX2luaXRyZF9tZW0odW5zaWduZWQgbG9u
ZyBzdGFydCwgdW5zaWduZWQgbG9uZyBlbmQpCj4gIAkJQ2xlYXJQYWdlUmVzZXJ2ZWQodmlydF90
b19wYWdlKHN0YXJ0KSk7Cj4gIAkJaW5pdF9wYWdlX2NvdW50KHZpcnRfdG9fcGFnZShzdGFydCkp
Owo+ICAJCWZyZWVfcGFnZShzdGFydCk7Cj4gLQkJdG90YWxyYW1fcGFnZXMrKzsKPiArCQlhdG9t
aWNfbG9uZ19pbmMoJnRvdGFscmFtX3BhZ2VzKTsKPiAgCX0KPiAgfQo+ICAjZW5kaWYKPiBAQCAt
ODgsNyArODgsNyBAQCB2b2lkIGZyZWVfaW5pdG1lbSh2b2lkKQo+ICAJCUNsZWFyUGFnZVJlc2Vy
dmVkKHZpcnRfdG9fcGFnZShhZGRyKSk7Cj4gIAkJaW5pdF9wYWdlX2NvdW50KHZpcnRfdG9fcGFn
ZShhZGRyKSk7Cj4gIAkJZnJlZV9wYWdlKGFkZHIpOwo+IC0JCXRvdGFscmFtX3BhZ2VzKys7Cj4g
KwkJYXRvbWljX2xvbmdfaW5jKCZ0b3RhbHJhbV9wYWdlcyk7Cj4gIAkJYWRkciArPSBQQUdFX1NJ
WkU7Cj4gIAl9CkZvciBjc2t5IHBhcnQsIGl0J3MgT0suCgogR3VvIFJlbgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
