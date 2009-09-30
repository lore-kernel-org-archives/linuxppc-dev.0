Return-Path: <JBeulich@novell.com>
Received: from vpn.id2.novell.com (vpn.id2.novell.com [195.33.99.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "emea1-mh.id2.novell.com", Issuer "APPS" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1A364B7BE5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Sep 2009 16:29:45 +1000 (EST)
Message-Id: <4AC316F2020000780001734C@vpn.id2.novell.com>
Date: Wed, 30 Sep 2009 07:29:38 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "roel kluin" <roel.kluin@gmail.com>
Subject: Re: linux-next: tree build failure
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<25e057c00909290251h55c0dc25o4ab1f2e84c920dca@mail.gmail.com>
In-Reply-To: <25e057c00909290251h55c0dc25o4ab1f2e84c920dca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

>>> roel kluin <roel.kluin@gmail.com> 29.09.09 11:51 >>>
>On Tue, Sep 29, 2009 at 11:28 AM, Jan Beulich <jbeulich@novell.com> =
wrote:
>>>>> Hollis Blanchard  09/29/09 2:00 AM >>>
>>>First, I think there is a real bug here, and the code should read like
>>>this (to match the comment):
>>>    /* type has to be known at build time for optimization */
>>>-    BUILD_BUG_ON(__builtin_constant_p(type));
>>>+    BUILD_BUG_ON(!__builtin_constant_p(type));
>>>
>>>However, I get the same build error *both* ways, i.e.
>>>__builtin_constant_p(type) evaluates to both 0 and 1? Either that, or
>>>the new BUILD_BUG_ON() macro isn't working...
>>
>> No, at this point of the compilation process it's neither zero nor one,
>> it's simply considered non-constant by the compiler at that stage
>> (this builtin is used for optimization, not during parsing, and the
>> error gets generated when the body of the function gets parsed,
>> not when code gets generated from it).
>>
>> Jan
>
>then maybe
>
>if(__builtin_constant_p(type))
>        BUILD_BUG_ON(1);
>
>would work?

Definitely not - this would result in the compiler *always* generating an
error.

Jan
