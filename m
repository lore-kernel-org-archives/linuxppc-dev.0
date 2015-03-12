Return-Path: <corbet@lwn.net>
Received: from vena.lwn.net (tex.lwn.net [70.33.254.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA1651A0BD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 00:27:32 +1100 (AEDT)
Date: Thu, 12 Mar 2015 09:00:15 -0400
From: Jonathan Corbet <corbet@lwn.net>
To: Pekka Enberg <penberg@iki.fi>
Subject: Re: [PATCH] mm: kill kmemcheck
Message-ID: <20150312090015.656c2f9c@lwn.net>
In-Reply-To: <55013B38.6040100@iki.fi>
References: <1426074547-21888-1-git-send-email-sasha.levin@oracle.com>
 <55013B38.6040100@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Vladimir Davydov <vdavydov@parallels.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Jianyu Zhan <nasa4836@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <mszeredi@suse.cz>,
 Christoph Lameter <cl@linux.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>,
 Andi Kleen <ak@linux.intel.com>, Russell King <linux@arm.linux.org.uk>,
 Jingoo Han <jg1.han@samsung.com>, James Morris <jmorris@namei.org>,
 Chris Bainbridge <chris.bainbridge@gmail.com>, Antti Palosaari <crope@iki.fi>,
 Mel Gorman <mgorman@suse.de>, Ritesh Harjani <ritesh.harjani@gmail.com>,
 Shaohua Li <shli@kernel.org>, Alexander Duyck <alexander.h.duyck@intel.com>,
 Wang Nan <wangnan0@huawei.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel J Blueman <daniel@numascale.com>, Rusty Russell <rusty@rustcorp.com.au>,
 Jens Axboe <axboe@fb.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Konstantin Khlebnikov <koct9i@gmail.com>,
 Willem de Bruijn <willemb@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Rabin Vincent <rabin@rab.in>, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>, Jiri Kosina <jkosina@suse.cz>,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Patrick McHardy <kaber@trash.net>,
 Christoffer Dall <christoffer.dall@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Eric Dumazet <edumazet@google.com>,
 Jungseung Lee <js07.lee@gmail.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Qiaowei Ren <qiaowei.ren@intel.com>,
 Prarit Bhargava <prarit@redhat.com>, bob picco <bpicco@meloft.net>,
 Sungjinn Chung <sungjinn.chung@samsung.com>,
 Quentin Lambert <lambert.quentin@gmail.com>, Hugh Dickins <hughd@google.com>,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
 Kukjin Kim <kgene@kernel.org>, Pranith Kumar <bobby.prani@gmail.com>,
 Tom Herbert <therbert@google.com>,
 "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
 Rik van Riel <riel@redhat.com>, Johannes Berg <johannes.berg@intel.com>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Eyal Perry <eyalpe@mellanox.com>, Joe Perches <joe@perches.com>,
 chishanmingshen <chishanmingshen@gmail.com>,
 Cyrill Gorcunov <gorcunov@openvz.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Yinghai Lu <yinghai@kernel.org>,
 Steven Honeyman <stevenhoneyman@gmail.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Theodore Ts'o <tytso@mit.edu>, Pekka Enberg <penberg@kernel.org>,
 David Vrabel <david.vrabel@citrix.com>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Michal Hocko <mhocko@suse.cz>,
 Paul Gortmaker <paul.gortmaker@windriver.com>, Jan Beulich <JBeulich@suse.com>,
 "moderated list:OPENRISC
 ARCHITEC..." <linux@lists.openrisc.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Sam Ravnborg <sam@ravnborg.org>, Andrey Ryabinin <a.ryabinin@samsung.com>,
 Dexuan Cui <decui@microsoft.com>, Suresh Siddha <sbsiddha@gmail.com>,
 Sasha Levin <sasha.levin@oracle.com>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Vegard Nossum <vegardno@ifi.uio.no>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 Andrey Konovalov <adech.fo@gmail.com>, Scott Wood <scottwood@freescale.com>,
 Bryan O'Donoghue <pure.logic@nexus-software.ie>,
 Dan Streetman <ddstreet@ieee.org>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 linux-fsdevel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "open list:MEMORY
 MANAGEMENT" <linux-mm@kvack.org>, Davidlohr Bueso <davidlohr@hp.com>,
 Paul Cassella <cassella@cray.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
 Xishi Qiu <qiuxishi@huawei.com>, Alexei Starovoitov <ast@plumgrid.com>,
 Jonas Bonn <jonas@southpole.se>, Herbert Xu <herbert@gondor.apana.org.au>,
 Richard Weinberger <richard@nod.at>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Aaron Tomlin <atomlin@redhat.com>,
 Greg Thelen <gthelen@google.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Fabian Frederick <fabf@skynet.be>, Michal Marek <mmarek@suse.cz>,
 Jungseok Lee <jays.lee@samsung.com>, Dave Jones <davej@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vlastimil Babka <vbabka@suse.cz>, Juergen Gross <jgross@suse.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 "open list:NETWORKING \[GENERAL\]" <netdev@vger.kernel.org>,
 Daniel Borkmann <dborkman@redhat.com>,
 Horia Geanta <horia.geanta@freescale.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 12 Mar 2015 09:07:36 +0200
Pekka Enberg <penberg@iki.fi> wrote:

> Can you elaborate on what exactly was discussed at LSF/MM? Preferably in 
> the commit log. ;-)

I'll have the report from that session up, hopefully by the end of the
week.

Thanks,

jon
