Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 697D0DDF47
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 04:15:09 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m34HF4Bv032295
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 13:15:04 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m34HF4PC242876
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 13:15:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m34HF4u2003041
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 13:15:04 -0400
Subject: Re: Please pull linux-2.6-mpc52xx.git
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080404163858.GA25717@lixom.net>
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47E938A8.9000103@semihalf.com>
	<fa686aa40803251151p457a2295w449222654be4d0d1@mail.gmail.com>
	<47F22C9A.4050501@semihalf.com> <47F60D5D.5090402@semihalf.com>
	<fa686aa40804040911o63e2e3efg2d9a74fff082fb16@mail.gmail.com>
	<fa686aa40804040914s3f682e37r16b4cb299e2fc97e@mail.gmail.com>
	<20080404163858.GA25717@lixom.net>
Content-Type: text/plain
Date: Fri, 04 Apr 2008 12:15:03 -0500
Message-Id: <1207329303.6518.16.camel@weaponx>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-04-04 at 11:38 -0500, Olof Johansson wrote:
> On Fri, Apr 04, 2008 at 10:14:34AM -0600, Grant Likely wrote:
> > On Fri, Apr 4, 2008 at 10:11 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > > > > I'm thinking 'optimized' defconfigs should go into a subdirectory.
> > >  > >
> > >  > > This requires a change to the top-level Makefile and shepherding this
> > >  > > change upstream. Could we perhaps try to avoid this by having optimized
> > >  > > defconfigs in the form of, for example:
> > >
> > >  I don't think changes are required to put them in a subdir:
> > >
> > >  $ mkdir arch/powerpc/configs/optimized
> > >  $ cp arch/powerpc/configs/mpc5200_defconfig
> > >  arch/powerpc/configs/optimized/lite5200_defconfig
> > >  $ make optimized/lite5200_defconfig
> > >
> > >  This works for me.
> > 
> > However, I'm not sure what the naming scheme should be for subdirectories.
> > 
> > board vendor?
> > host processor?
> > just one big directory for board specific defconfigs?
> > 
> > Olof, Kumar, Josh; any thoughts?
> > 
> > Not that it matters much; files are easy to move around later.
> 
> I really like the idea. It would probably make sense to organize it in
> the same way as the platforms are done today, i.e. per processor/platform
> family. And then have shared/merged configs in the main config directory.

Yes.  I was thinking the same already for 4xx.  Essentially:

configs/ppc44x_defconfig
configs/ppc40x_defconfig
configs/44x/<board>_defconfig
configs/40x/<board>_defconfig

josh
