Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 6882EDE3FC
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 00:58:12 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so477707anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 07:58:11 -0700 (PDT)
Message-ID: <fa686aa40804210758r70a5906eqb090cd3d8b797317@mail.gmail.com>
Date: Mon, 21 Apr 2008 08:58:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
In-Reply-To: <20080421144938.GA25627@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190959.GD4407@polina.dev.rtsoft.ru>
	<fa686aa40804210719x475698f8n3b82e795547bfc70@mail.gmail.com>
	<20080421143313.GB18008@polina.dev.rtsoft.ru>
	<20080421144938.GA25627@polina.dev.rtsoft.ru>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 8:49 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
>  > > Should this really be a arch_initcall()?  Would it be better for
>  > > platforms needing it to call it explicitly from one of the platform's
>  > > machine_arch_initcall()?  Otherwise it gets called for all platforms
>  > > in a multiplatform kernel.
>  >
>  > Ok, I'll place it into qe_reset().
>
>  Ugh, no, I can't. qe_reset() is called too early. And I don't like
>  having every QE board file to call this through machine_arch_initcall...
>  Hmm, what to do.. well, is this thaat bad to call this for every
>  platform?..

Its not great.  It has a boot time impact for every platform compiled
into the kernel.  The problem gets worse every time another block of
code uses this method.  Personally I prefer platform code calling it
explicitly.

Making it an of_platform device would also eliminate that problem, but
you'd need a method to synchronize the driver with its users.

I'm not going to raise a big stink about it, but the issue should not
be ignored.

Cheers,
g.

>
>
>
>  --
>  Anton Vorontsov
>  email: cbouatmailru@gmail.com
>  irc://irc.freenode.net/bd2
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
