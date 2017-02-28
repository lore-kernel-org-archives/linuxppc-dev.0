Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXZNf3qxszDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 21:21:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ben Hutchings <ben@decadent.org.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild@vger.kernel.org
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
 linux-c6x-dev@linux-c6x.org, Michal Simek <monstr@monstr.eu>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Marcin Nowakowski <marcin.nowakowski@imgtec.com>, devicetree@vger.kernel.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Michal Marek <mmarek@suse.com>, Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 openrisc@lists.librecores.org, Mark Salter <msalter@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Aurelien Jacquiot <a-jacquiot@ti.com>,
 Jonas Bonn <jonas@southpole.se>, linux-kernel@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Emese Revfy <re.emese@gmail.com>
Subject: Re: [PATCH] kbuild: avoid unrecognized option error for external DTC
In-Reply-To: <1488204416.2819.9.camel@decadent.org.uk>
References: <1488174052-2530-1-git-send-email-yamada.masahiro@socionext.com>
 <1488204416.2819.9.camel@decadent.org.uk>
Date: Tue, 28 Feb 2017 21:21:02 +1100
Message-ID: <87tw7epqep.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben Hutchings <ben@decadent.org.uk> writes:

> [ Unknown signature status ]
> On Mon, 2017-02-27 at 14:40 +0900, Masahiro Yamada wrote:
>> Since commit 6b22b3d1614a ("kbuild: Allow using host dtc instead of
>> kernel's copy"), it is possible to use an external dtc.=C2=A0=C2=A0In th=
is
>> case, we do not know which options are supported on it.
>>=20
>> Commit bc553986a2f7 ("dtc: turn off dtc unit address warnings by
>> default") gives -Wno-unit_address_vs_reg, but this options is only
>> recognized by v1.4.2 or later.
>>=20
>> If an older version is specified, the build fails:
>
> But the option to use an external dtc was intended to allow testing of
> newer versions.  If there's no reason to use this option to run an
> older version, why bother trying to support that?

+1

That's a lot of added complexity, when the answer could just be "use the
kernel dtc".

cheers
