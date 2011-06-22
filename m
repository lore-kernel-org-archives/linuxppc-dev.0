Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F515B6F57
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 17:49:19 +1000 (EST)
Received: by qwi4 with SMTP id 4so409628qwi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 00:49:16 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <4DF7BF84.8030000@freescale.com>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
	<BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
	<4DF7BE43.1010407@freescale.com> <4DF7BF84.8030000@freescale.com>
Date: Wed, 22 Jun 2011 09:49:16 +0200
Message-ID: <BANLkTikcn7ghNF7YW7LO+=Qs_4A=RHxJSQ@mail.gmail.com>
Subject: Re: Mapping an executable page
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 14, 2011 at 10:07 PM, Timur Tabi <timur@freescale.com> wrote:
> Timur Tabi wrote:
>> Hmmm.... I find that surprising. =A0Memory allocated via ioremap() is su=
pposed to
>> be available in interrupt handlers, where TLB mappings can't be created
>> on-the-fly. =A0I'm not sure that your observation is correct.
>
> Ok, it turns out I'm wrong. =A0As long as the page is in the page tables =
(i.e.
> physically present in RAM), you can take a TLB miss in an interrupt handl=
er, and
> the TLB miss handler will create a TLB for you.
>
> This means that ...
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long dummy =3D =
*(volatile unsigned long *)p;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void)dummy;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> * After these changes (make sure all code is mapped + make sure to
>> read all pages so that the TLBs are updated), my scenario works fine.
>
> is not going to work reliably, because it assumes that the TLBs created b=
y your
> multiple ioremap() calls will still be there when your code is called.
>
> If you use just a single ioremap() call, but still touch every page, that=
 should
> work for you just as well.

I am using a single __ioremap call.
You have a point about the reliability of this: if an interrupt occurs
between the mapping or dummy reading, and the point where the actual
code is executing, some TLB entries may have been replaced, right?
I think I can make it more reliable by dummy reading the pages *after*
I disabled interrupts on that processor, immediately before jumping to
the boot code. Is that correct?
(note that I have to disable interrupts anyhow for the boot code to
work properly without interruptions to 'linux land'.

Thanks for your input,
Thomas
