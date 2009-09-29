Return-Path: <roel.kluin@gmail.com>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214]) by ozlabs.org (Postfix) with ESMTP id 0661DB7B94
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 19:51:59 +1000 (EST)
Received: by fxm10 with SMTP id 10so770576fxm.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 02:51:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4AC1E15502000078000516B5@vpn.id2.novell.com>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
Date: Tue, 29 Sep 2009 11:51:56 +0200
Message-ID: <25e057c00909290251h55c0dc25o4ab1f2e84c920dca@mail.gmail.com>
Subject: Re: linux-next: tree build failure
From: roel kluin <roel.kluin@gmail.com>
To: Jan Beulich <jbeulich@novell.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, hollisb@us.ibm.com, linux-kernel@vger.kernel.org,
	kvm-ppc@vger.kernel.org, linux-next@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 29, 2009 at 11:28 AM, Jan Beulich <jbeulich@novell.com> wrote:
>>>> Hollis Blanchard =A009/29/09 2:00 AM >>>
>>First, I think there is a real bug here, and the code should read like
>>this (to match the comment):
>> =A0 =A0/* type has to be known at build time for optimization */
>>- =A0 =A0BUILD_BUG_ON(__builtin_constant_p(type));
>>+ =A0 =A0BUILD_BUG_ON(!__builtin_constant_p(type));
>>
>>However, I get the same build error *both* ways, i.e.
>>__builtin_constant_p(type) evaluates to both 0 and 1? Either that, or
>>the new BUILD_BUG_ON() macro isn't working...
>
> No, at this point of the compilation process it's neither zero nor one,
> it's simply considered non-constant by the compiler at that stage
> (this builtin is used for optimization, not during parsing, and the
> error gets generated when the body of the function gets parsed,
> not when code gets generated from it).
>
> Jan

then maybe

if(__builtin_constant_p(type))
        BUILD_BUG_ON(1);

would work?

Roel
