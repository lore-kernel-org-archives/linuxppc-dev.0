Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69618C6787E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEEE20841
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iiyM3l07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEEE20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T58S26RhzF37r
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 14:15:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iiyM3l07";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T55q6F3VzF368
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 14:13:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="iiyM3l07"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T55q5Slyz9sj3; Mon,  8 Oct 2018 14:13:03 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42T55q4rSvz9sCr; Mon,  8 Oct 2018 14:13:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538968383;
 bh=MnKDv+z7FDgPVlK4fKslLnzAbY5EvICmYu26e370dh4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iiyM3l07NvhgoOqCyNtHWht6rK2ZtHBNGy0zldSJ1umt1enNAj3NGIztFNMHl6WSl
 65KIKwK3UAb6vAdTC5kA3m1Ev7rM2VJah5PN3FYtfERRcJuWn/71M1pZ++bcw01WmO
 IoJx5mb4KokUV4W5jPAORT57Onm13lmp6Ozeme0M=
Date: Mon, 8 Oct 2018 13:02:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v4 25/32] KVM: PPC: Book3S HV: Invalidate TLB when nested
 vcpu moves physical cpu
Message-ID: <20181008020215.GR7004@umbus.fritz.box>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
 <1538654169-15602-26-git-send-email-paulus@ozlabs.org>
 <20181005040908.GK7004@umbus.fritz.box>
 <20181005042350.GA3309@fergus>
 <20181005045428.GO7004@umbus.fritz.box>
 <20181005053226.GB3309@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="//h4sZKAxcnndsN6"
Content-Disposition: inline
In-Reply-To: <20181005053226.GB3309@fergus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--//h4sZKAxcnndsN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 03:32:26PM +1000, Paul Mackerras wrote:
> On Fri, Oct 05, 2018 at 02:54:28PM +1000, David Gibson wrote:
> > On Fri, Oct 05, 2018 at 02:23:50PM +1000, Paul Mackerras wrote:
> > > On Fri, Oct 05, 2018 at 02:09:08PM +1000, David Gibson wrote:
> > > > On Thu, Oct 04, 2018 at 09:56:02PM +1000, Paul Mackerras wrote:
> > > > > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > > >=20
> > > > > This is only done at level 0, since only level 0 knows which phys=
ical
> > > > > CPU a vcpu is running on.  This does for nested guests what L0 al=
ready
> > > > > did for its own guests, which is to flush the TLB on a pCPU when =
it
> > > > > goes to run a vCPU there, and there is another vCPU in the same VM
> > > > > which previously ran on this pCPU and has now started to run on a=
nother
> > > > > pCPU.  This is to handle the situation where the other vCPU touch=
ed
> > > > > a mapping, moved to another pCPU and did a tlbiel (local-only tlb=
ie)
> > > > > on that new pCPU and thus left behind a stale TLB entry on this p=
CPU.
> > > > >=20
> > > > > This introduces a limit on the the vcpu_token values used in the
> > > > > H_ENTER_NESTED hcall -- they must now be less than NR_CPUS.
> > > >=20
> > > > This does make the vcpu tokens no longer entirely opaque to the L0.
> > > > It works for now, because the only L1 is Linux and we know basically
> > > > how it allocates those tokens.  Eventually we probably want some way
> > > > to either remove this restriction or to advertise the limit to the =
L1.
> > >=20
> > > Right, we could use something like a hash table and have it be
> > > basically just as efficient as the array when the set of IDs is dense
> > > while also handling arbitrary ID values.  (We'd have to make sure that
> > > L1 couldn't trigger unbounded memory consumption in L0, though.)
> >=20
> > Another approach would be to sacifice some performance for L0
> > simplicity:  when an L1 vCPU changes pCPU, flush all the nested LPIDs
> > associated with that L1.  When an L2 vCPU changes L1 vCPU (and
> > therefore, indirectly pCPU), the L1 would be responsible for flushing
> > it.
>=20
> That was one of the approaches I considered initially, but it has
> complexities that aren't apparent, and it could be quite inefficient
> for a guest with a lot of nested guests.  For a start you have to
> provide a way for L1 to flush the TLB for another LPID, which guests
> can't do themselves (it's a hypervisor privileged operation).  Then
> there's the fact that it's not the pCPU where the moving vCPU has
> moved to that needs the flush, it's the pCPU that it moved from (where
> presumably something else is now running).  All in all, the simplest
> solution was to have L0 do it, because L0 knows unambiguously the real
> physical CPU where any given vCPU last ran.

Ah, I see.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--//h4sZKAxcnndsN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu6uqUACgkQbDjKyiDZ
s5I9XA/7B4vcSuzaO3VSC+zX4rzz6mBzx2SoAc/lh1zpFlf1IuNaBwEi6UwitKpm
UzKHgRXMqF12VgUpOkoBKHQ7NQnRvf13v1zi3HKldWIODSlYMM/zApsytodm/cPd
TjWFwJXgignsShITDZfPisthuR3CJ4ihS4+hHfZWrJ6s+h8ZTawNzfvwet7k9UEC
aZZMe+/H2V66qp74XqMsa/fCI6M6ny3ZOwFpng1wIzZDHyTRK+RZU8TMwUok7fBH
baBGi8mf3OtAdJ5jLObEBJH93O/SA+chaBDvI2wnZCbVWHMIK8m+yfhmBjXSuSaL
zqMTjquRes4HGIqTTS+SeqDwlmzte73ZdYXnyrRxouwB/QkVdB6TgMpBP/Vc+EdM
qXVyPxyLHmOqjw96ctJmxmWYvWqKTmYjTwyVf6EoChr3MdtrpKtdmSV35HWeTMNO
zhoIdkhkJH4ov8QoMiVaYSTGuy6CGwLk3Cswd4yeNL3Y0b9Ikjg9VIGJo+Il1YWZ
+hjpwWcfwKpQkFClCXagBekwOtK0gocfbji3bRi/c5gR++gy2r3IaxhMzEuHcMaP
RjDVh+OCJKT53VGYRFekRsCqw1FfNYzKiXs2pV45SAH2ZMj1fSTPLtqXP9fYVBeI
l+7ouo1sVmbAgKD4cS/xgKyV6eZRbGGiMRj8xd5zyDx/AFCc5G4=
=ANA2
-----END PGP SIGNATURE-----

--//h4sZKAxcnndsN6--
