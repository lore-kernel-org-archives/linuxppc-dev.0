Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94E60B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 09:30:03 +1100 (EST)
In-Reply-To: <fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0AE26D40-D051-4CDE-878C-64CC8EF33E07@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
Date: Tue, 24 Nov 2009 23:36:46 +0100
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> +       model = "NintendoGameCube";
>> +       compatible = "nintendo,gamecube";
>
> To date, we've been using the same form for both the model and
> compatible properties.  Specifically the <vendor>,<model> form to
> maintain the namespace.

That, however, is a) useless; and b) not totally correct.
The "model" property should show an exact model number if available.
You should use the "vendor," thing indeed.

If you don't have any better model # to use, using the same thing
as "compatible" is okay I suppose.  But it's not the _best_ thing
to put here if you have the choice.  Maybe you should say  
"nintendo,RVL-001"
(well, that's Wii, you want the similar thing for NGC, but you get
the point I hope).

>> +               compatible = "nintendo,flipper";
>> +               clock-frequency = <162000000>; /* 162MHz */
>> +               ranges = <0x0c000000 0x0c000000 0x00010000>;
>
> Since you're only doing 1:1 mappings; you could replace this with an
> empty "ranges;" property instead.

You could, but being explicit about the supported ranges isn't
bad either.

> Hint:  If you move the interrupt-parent property up to the root node,
> then you don't need to specify it in every single device node; it will
> just inherit from the parent.

If you have only one interrupt controller, like here, you don't
need to refer to it _at all_ :-)


Segher
