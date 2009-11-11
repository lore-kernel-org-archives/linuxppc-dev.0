Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9C5BB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 07:03:22 +1100 (EST)
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
	<9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
	<20091111183753.GA31815@rakim.wolfsonmicro.main>
	<fa686aa40911111124i12b72196xdba7000b13b3bdc@mail.gmail.com>
	(sfid-20091111_192512_321401_1F7ED21B)
Message-Id: <6FB97780-074F-41B7-AF78-5F4817E7DE3A@opensource.wolfsonmicro.com>
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40911111124i12b72196xdba7000b13b3bdc@mail.gmail.com>
	(sfid-20091111_192512_321401_1F7ED21B)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7D11)
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
Date: Wed, 11 Nov 2009 20:03:22 +0000
Cc: John Bonesio <bones@secretlab.ca>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11 Nov 2009, at 19:24, Grant Likely <grant.likely@secretlab.ca>  
wrote:

> On Wed, Nov 11, 2009 at 11:37 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, Nov 11, 2009 at 11:38:06AM -0500, Jon Smirl wrote:
>>>> Providing a final valid data point to the driver would possibly  
>>>> even
>>>> make things worse since if it were used then you'd have the  
>>>> equivalent
>>>> race where the application has initialized some data but not yet  
>>>> managed
>>>> to update the driver to tell it it's being handed over; if the  
>>>> driver
>>
>>> That's an under run condition.
>>
>> Yes, of course - the issue is that this approach encourages them,  
>> making
>> the system less robust if things are on the edge.  The mpc5200  
>> seems to
>> be not just on the edge but comfortably beyond it for some reason.
>
> I can't reproduce the issue at all as long at the dev_dbg() statement
> in the trigger stop path is disabled.  With it enabled, I hear the
> problem every time.  The 5200 may not be a speedy beast, but it is
> plenty fast enough to shut down the audio stream before stale data
> starts getting played out.

Yes, that does sound entirely consistent with the problem being a  
latency issue if you're sending the dev_dbg() output to the serial  
port. I'd be surprised if it were anything else to be honest.
