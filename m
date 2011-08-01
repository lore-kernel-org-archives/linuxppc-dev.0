Return-Path: <dsahern@gmail.com>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E92DB6FD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 22:44:40 +1000 (EST)
Received: by pzk1 with SMTP id 1so8975640pzk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Aug 2011 05:44:38 -0700 (PDT)
Message-ID: <4E369FB4.3070603@gmail.com>
Date: Mon, 01 Aug 2011 06:44:36 -0600
From: David Ahern <dsahern@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] perf: powerpc: Disable pagefaults during callchain stack
	read
References: <1312059200-11563-1-git-send-email-dsahern@gmail.com>	
	<1312192792.2617.381.camel@laptop>
	<1312195147.8793.794.camel@pasglop>
In-Reply-To: <1312195147.8793.794.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	paulus@samba.org, anton@samba.org, acme@ghostprotocols.net,
	mingo@elte.hu, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/01/2011 04:39 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2011-08-01 at 11:59 +0200, Peter Zijlstra wrote:
>>> Signed-off-by: David Ahern <dsahern@gmail.com>
>>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> CC: Anton Blanchard <anton@samba.org> 
>>
>> Hmm, Paul, didn't you fix something like this early on? Anyway, I've
>> no
>> objections since I'm really not familiar enough with the PPC side of
>> things. 
> 
> I'm travelling so I haven't had a chance to review properly or even test
> but it looks like an ad-hoc fix for the immediate problem.
> 
> Ultimately, I want to rework that stuff to do a __gup_fast like x86 does
> (maybe as a fallback from an attempt at access first) so we work around
> access permissions blocked by lack of dirty/accessed bits but in the
> meantime, this should fix the immediate issue.

The problem goes back to all kernel releases with perf, so this patch
should get applied to the stable trains too.

David

> 
> Cheers,
> Ben.
> 
> 
