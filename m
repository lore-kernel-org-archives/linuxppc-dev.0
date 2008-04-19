Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 30D99DDE20
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 02:23:52 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so280630anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 09:23:50 -0700 (PDT)
Message-ID: <fa686aa40804190923g2f114d3bl534ab19e0267d324@mail.gmail.com>
Date: Sat, 19 Apr 2008 10:23:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [RFC/POWERPC] mpc5200: remove "mpc5200b-*" from compatible lists
	in dts files
In-Reply-To: <50bbe43673e46cc8d3a02eb4c03d87e9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080418161218.12738.25844.stgit@trillian.secretlab.ca>
	<50bbe43673e46cc8d3a02eb4c03d87e9@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, m8@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 19, 2008 at 3:23 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > The mpc5200b is a bug fix of the mpc5200 with a few incompatible changes.
> > By rights, the current dts trees are the most "correct", but in practical
> > purposes there is no value in the 5200b devices having 2 compatible
> > entries for each internal peripheral node.  Freescale has done a good job
> > of documenting exactly where the incompatibilities lie, so it restrict
> > the extra compatible properties to devices with *documented* changes.
> >
>
>  And what happens when later an "undocumented change" is found?  The
>  device tree should always list the exact version of device used, even
>  if all clients (i.e., the Linux kernel) only use the less-specific
>  "compatible" value; that way, if a need to distinguish arises later
>  (e.g., a model-specific bug workaround), a client can detect the exact
>  model of device without needing a new device tree (that the client in
>  general has no control over).

Yes, I fully agree and understand that.  However, even that doesn't
fully solve the problem.  At what level do you stop trying to describe
the device versions in the device tree?  What about the case where an
earlier silicon version has an undocumented errata?  At some point,
compatible doesn't help us and we need to resort to looking at other
factors (like PVR/SVR) to determine what the device really is.

Early on I decided to differentiate between the 5200 and the 5200b;
however, from a practical sense they really are the same part and
there is no practical advantage to differentiating between them.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
