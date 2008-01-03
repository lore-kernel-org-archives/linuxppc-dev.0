Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 4573ADDEBB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 06:13:09 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1151315anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 11:13:08 -0800 (PST)
Message-ID: <fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
Date: Thu, 3 Jan 2008 12:13:08 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477D2F52.7090306@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>
	<477D24AA.4050804@freescale.com>
	<fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>
	<477D2F52.7090306@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/3/08, Scott Wood <scottwood@freescale.com> wrote:
> Grant Likely wrote:
> > On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
> >> Grant Likely wrote:
> >>
> >>> Why not be a child of the i2c bus with a phandle to the ssi bus?
> >> Because when I probe the SSI node, I want to know what the attached codec is.
> >>   So if anything, I would need a pointer from the SSI bus *to* the respective
> >> child on the I2C bus.
> >
> > That's fine too (it's what is done with Ethernet PHYs).  My preference
> > is the other way around, but it's not a big issue in this case.
>
> I'd just link in both directions, and let software follow it in
> whichever direction it prefers.

Gah!  Don't do that!  Then you need to maintain both directions in the
dts file.  Software is good at generating reverse mappings.  Don't put
that burden on the dts author.  (the software principle of defining
things in one place only applies here)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
