Return-Path: <mnazarewicz@gmail.com>
Sender: =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mnazarewicz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: linux-kernel@vger.kernel.org, "Gilad Ben-Yossef" <gilad@benyossef.com>
Subject: Re: [RFC PATCH 0/9] Remove useless on_each_cpu return value
References: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
Date: Tue, 03 Jan 2012 15:25:49 +0100
MIME-Version: 1.0
From: "Michal Nazarewicz" <mina86@mina86.com>
Message-ID: <op.v7iidbwz3l0zgt@mpn-glaptop>
In-Reply-To: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
Cc: linux-ia64@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@ghostprotocols.net>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Tony Luck <tony.luck@intel.com>,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 03 Jan 2012 15:19:04 +0100, Gilad Ben-Yossef <gilad@benyossef.co=
m> wrote:
> on_each_cpu() returns as its own return value the return value of
> smp_call_function(). smp_call_function() in turn returns a hard
> coded value of zero.
>
> Some callers to on_each_cpu() waste cycles and bloat code space
> by checking the return value to on_each_cpu(), probably for
> historical reasons.
>
> This patch set refactors callers to not test on_each_cpu()
> (fixed) return value and then refactors on_each_cpu to
> return void to avoid confusing future users.
>
> In other words, this patch aims to delete 18 source code lines
> while not changing any functionality :-)
>
> I tested as best as I could the x86 changes and compiled some
> of the others, but I don't have access to all the needed hardware
> for testing. Reviewers and testers welcome!

Other then the lack of Signed-off-by in the patches, looks good to me,
even though personally I'd choose a bottom-up approach, ie. make
smp_call_function() return void and from that conclude that
on_each_cpu() can return void.  With those patches, we have a situation,=

where smp_call_function() has a return value which is then lost for no
immediately apparent reason lost in on_each_cpu().

-- =

Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz=
    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
