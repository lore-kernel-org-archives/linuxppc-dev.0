Return-Path: <linuxppc-dev+bounces-26663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93606C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 11:32:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdlL92JQXz2yvP;
	Mon, 07 Sep 2026 21:32:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.164 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788780769;
	cv=pass; b=Op4egOcTcrI4RYo3V+mGtR485LIDp8AtfzR2RbJBCBfG5HeVXoyzjQz+FCMPgLQkVCdpbfxfzCWYutHGK/Ur2oPLkn20IDnd+w1k/4Ske97ZPz6DSlXqxUIoUZ2ZEqCFybwg7KIMmUZoTl3uLxzkJh5piTu3oQRA0ri9KmAwIN2k+B6aqeH+J/eJ+m/VjtQMUNa+E0DKPyn04/k7nv4KdLiFekZgZca9hG7eydb/ORMk0P0o8EwwKZbRdVuSsavpvt7leHGrI7gm2zk3KQlZ4rpigeLLKjlHviHq9TVVrQfT7sklFJrdzeKzgwlYHNAktAuFvM1+/Dxu7MQU47JQQA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788780769; c=relaxed/relaxed;
	bh=ntDCvurw/Q5G9w27lopjU9J9umfLOFHZ8yY6//RAPf0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=O1TZikQBG0ypQ4HCmMRVPQ5gh11J5tnWIa85fQq3fWMPdS/bSfZmve5zO2jcJY70TqWJCHOmAlg9dBxcyJtNd7f+EuWiDJjKhWLGTgdbbXg7R0s9+a6wYNGa2Ddpcck9R2TiQtDt6Z2r53Pqg5YiG8SIONbu5+AEAeRtzJN3rH0WQAnAi9Es8h3OHgwidDGOAW21HStmLSx25pd06AC9riqcRqE1HBp+EAVJ2uafQMTPt6KDWu8nIXK/Uph4frpqhjsgCMGq7gO3HXqSjfoseqOG9qb93WO04CVRpnHI0SlCqwaEJWu/d44WP/me4ohnfy7UFaYjT8AO7Z2TU3MESg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AbdmOZ4A; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=DDn/MHWR; dkim-atps=neutral; spf=pass (client-ip=81.169.146.164; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AbdmOZ4A;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=DDn/MHWR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.164; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdlL20XbTz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 21:32:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1788780749; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=U2PtT2lH5ZmkqJSv1IAjAIqK4pOitqZheS/rP6mTZaxxr6/T/k8TWbI17kl8rT6qhl
    7zdZOPUMHUpJvQYgfSlOWeFVjx7xDTWbsbwHa943RGz8+j7jDzaSt+L45InFv6tJwk+u
    EYqO2pv/AgqJKnZQBLaMpliPjepxBfeHinh7bhyUxi6JqbkhA1fChBVaSmb9fT6gNBeG
    nXPJlHh8OxXFOH+WM08kT/toI4HWbn36tpBZW3flAWxYhAJOWQijlMheE2KRI5byRPXb
    NgZxQMow3CAkwJQ4nEej8tPFxJQnOETV307t2/K9hTP2G51AFgXFA0i7yxEizEE2x15J
    8agA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788780749;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ntDCvurw/Q5G9w27lopjU9J9umfLOFHZ8yY6//RAPf0=;
    b=kj65N7XkVBdRjVCb8/zD4cTx01g9YMccmcpxgfsk1bNx78Z6vsWtWIAZGp79Yv9ZdZ
    UwTODyvlVLsNZZvk23GQVeXbXb61yLaJMOvxKpuIfQ8GRLJO9u2IvHRI3gNqm87tIRFT
    TDiY2KnIprtP/qlXSPvj00B0BTF9ff13bInT2tfGSS6aNxoRst1sybjcDSYhwxnVWwwB
    sQ7ViJyYbAAMcTPjktVhDDZ7q2jN8gSjg6pf1F+kHwrj3sB+XhTYZSmkVdgafVYDJugz
    RmRV7dVd6dRAc8ZjQK3dmEQpFRH2N6ei3PMrymruPtc7uX2PIln9u2Thk3oZ8SHnRMnB
    WrMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788780749;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ntDCvurw/Q5G9w27lopjU9J9umfLOFHZ8yY6//RAPf0=;
    b=AbdmOZ4AS2P9DvRfCrg8I9xh8/Lntwg9WykZBK1mIF2Vb/0wTOgxBSzEbuYzk9IzK5
    OSK8pfOXp5JjSqFZpSK0rNaTgLhtOzhaE7pdUJisa1shV1xyuyzBF2ZN28aTUOt18A/G
    27mf8EVpY/ZYP81oC+1+Kk7Q9w1NIwL5MWRbD1ycRbgyg0MRUaCHLan9ivCYIuA/glhW
    Wmw8WGIbMIaWGU80LuwHS9ehbTJN4AKS/gqiPr0wuvrTQus86nU1IwL5Sln1jWwsU9C2
    JquahHp8KGzc8fEBIcdfS7bmNSZj8/W9mZQJz5gdu1O7hL5fOvLZxmZ6jvBt3ElZv2tI
    0V4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788780749;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ntDCvurw/Q5G9w27lopjU9J9umfLOFHZ8yY6//RAPf0=;
    b=DDn/MHWRwrX00eRzZR1bVEEPScKdu0aS/SSR8aOFAAAytdLG8sabR+kz0aUCE58xrf
    yn0/8G4tvp5pGLYLrCAg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5m3s37ACXrz3InoE0UdH26ccEnqh7RR4cPrIQ=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ee2bee287BWTI6z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Sep 2026 13:32:29 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [Linux PPC] Disable PREEMPT
Date: Mon, 7 Sep 2026 13:32:18 +0200
Message-Id: <1D6F66F5-E181-4814-A7E5-E52A678D37A2@xenosoft.de>
References: <ap568I8bQAmSKWj5@kunlun.suse.cz>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Christophe Leroy <chleroy@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 hypexed@yahoo.com.au, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <ap568I8bQAmSKWj5@kunlun.suse.cz>
To: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailer: iPhone Mail (23G83)

On 07 September 2026 at 10:51 am, Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:

There is the obvious question which I did not notice answered in this
thread: Did you set up sysrq and/or kdump and find out where the kernel
is stuck?

Thanks

Michal

- - -

I think I need kexec for kdump due to the system freezing after activating o=
f KVM HV. Unfortunately kexec doesn=E2=80=99t work on my machines.

Further information: https://github.com/chzigotzky/kernels/releases/tag/Kexe=
c=


