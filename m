Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f212.google.com (mail-gx0-f212.google.com
	[209.85.217.212]) by ozlabs.org (Postfix) with ESMTP id A4F621007E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 07:19:23 +1100 (EST)
Received: by gxk4 with SMTP id 4so12660907gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 12:19:21 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B0AE603.9050208@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<4B0AE603.9050208@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 23 Nov 2009 13:19:01 -0700
Message-ID: <fa686aa40911231219k3a52b9fdn66b8cffb735e5c2f@mail.gmail.com>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 23, 2009 at 12:44 PM, Albert Herranz
<albert_herranz@yahoo.es> wrote:
> Grant Likely wrote:
>> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es=
> wrote:
>>> + =A0 =A0 =A0 /* devices contained int the flipper chipset */
>>> + =A0 =A0 =A0 soc {
>>
>> It would be better to rename this as IMMR or the bus type. =A0This node
>> doesn't actually describe the entire chip, but describes the internal
>> memory mapped registers.
>>
>
> Can you please elaborate more on this or point me to documentation?
> The soc node here tries to represent the big multi-function chip that int=
egrates most of the devices of the video game consoles ("Flipper" on the Ni=
ntendo GameCube and "Hollywood" on the Wii).

Right.  Much like many other SoCs.  However, the SoC has all these
devices + the cpu core + the memory controller, and probably some
other stuff.  Whereas this particular node only encapsulates the
integrated peripherals on an internal bus, so the node really is
describing the internal bus, not the entire SoC.  On some chips it is
documented as the "internally memory mapped registers", or IMMR.  So,
it is better to name this node in a way that reflects what it is (an
internal bus) instead of as the whole chip.

Similarly, it is better to use a compatible value of something like:
compatible =3D "nintendo,flipper-immr"; (instead of "nintendo,flipper")
because your describing just the internal bus, not the entire chip.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
