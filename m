Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92AB7B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Apr 2011 13:59:17 +1000 (EST)
Received: by iwc10 with SMTP id 10so1383018iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 20:59:13 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110420193145.GA15439@merkur.ravnborg.org>
References: <20110420084449.23741.45580.stgit@ponder>
	<20110420193145.GA15439@merkur.ravnborg.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 20 Apr 2011 21:58:53 -0600
Message-ID: <BANLkTimYJu5BeCb3i64KVTDcTn8SnFsPXQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: stop exporting irq_map
To: Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2011 at 1:31 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> +
>> =A0irq_hw_number_t virq_to_hw(unsigned int virq)
>> =A0{
>> =A0 =A0 =A0 return irq_map[virq].hwirq;
>> =A0}
>> =A0EXPORT_SYMBOL_GPL(virq_to_hw);
>
> General comment...
> kernel/irq/* denote the virtual irq numbers "irq".
> powerpc uses "virq" for the same.

I might do that, but I'm early in this refactoring work yet so I'm not
entirely sure what the final result is going to look like.  At least
with the 'virq_' prefix I can find the powerpc specific functions that
are candidates for refactoring or replacing.

g.

>
> Sometimes it is confusing that two different names is used
> for the same thing.
>
> The intent of this patch is to centralize access to a common data structu=
re,
> but this could also be a good candidate for a terminology shift if
> this is considered.
>
> "git grep virq" shows a lot of hits - especially in arm, powerpc.
> So what I suggest is obviously only a small step in the direction
> of using "irq" all over.
>
> =A0 =A0 =A0 =A0Sam
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
