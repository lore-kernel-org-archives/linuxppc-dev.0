Return-Path: <linuxppc-dev+bounces-18609-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE454EC01A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:50:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQMh35d5z2yfl;
	Mon, 23 Mar 2026 18:50:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252256;
	cv=none; b=Mqg1v9/r8vX/eDagN5om5tcIXolU5IcSHGqK+z8K/Hn5zf+EkMVwmvEk2IFQ/BojWSo76jxF3z/T9Ld0HaVQfjRGXec4y99Nd0ue1f2kSpJ4mQJOiK3vo7BjaAznNip1+g2GHn6lsm4/uNtGFhpT+dVrkanr4bpA9uxZ38t4QHRwyQ9xBa8KIScpWIArE47VV1MYJJ5C+f3odtQMLbm5xER1hVASL1+IWLdZdImOa3ZYwFP/09MeYxM7Aif7/sWjTvpFNjFfhF5xGFtSetjaRiaXYynpbok8jsfypyYpVGcZEbhaqA5eYzjTRyYGfwsrTdzf6DPT5vs7opVsNQniuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252256; c=relaxed/relaxed;
	bh=InEtOX13C+WYX5juGdVt/QbMbLMFenzxfLEuqeNUPTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqkmZN/saGwfnJ8UKknjw8wnBLwJdikaZi2PPxTTP6tiK5cUeNUR41lQ43LQMQfVbGGwT4mL6Ilm0V9NpfqlB6r/iPCajOE1lTn1KxCnoHXwNTWan8aHw3R1bGQlfBJ0mfH10D623XqdrN2+GblhOm6C+Rd6+Jz3axr/vGNNUp/qDXQjPNzk5PtrmzHHfA5bHT4Q0VJkfB4bcBFStQ96+LxCJjqEkXl48uxScCCnPk2XGrQK8RJrV7ctC7IsvvPD7PQ6qOi7UP+Pdwb0QONB5wlfm//QEQ/hkpAV08c6WHBr+cH1aw3/mi4oWhWm7DawjYg8WaF+aDn/JcmWMdoKvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TGqMdeOM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TGqMdeOM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQMg5GcKz2yZN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:50:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3694743DE7;
	Mon, 23 Mar 2026 07:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D31AC2BCB0;
	Mon, 23 Mar 2026 07:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774252254;
	bh=VwtSJIp8ENHMSX+xFEF3sWtn+Y2VJrcUVbX8lQmkP+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGqMdeOMBMS40jbvN3VCndGyHRmX53aBTL8cPWIJ9jdvYJeiJ8heg2vZp7U4d7WVn
	 1u/yLe04dbEr8J1T3VCKnJxf2AY7v5xpvA7cb7yvIjE6DAvM1Z7nWI+Dgc0bBgMU50
	 qqH+S53n8p4Fd+UNSqcYmYHe4qs/l16LoK7Zr2R8=
Date: Mon, 23 Mar 2026 08:50:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	nathan@kernel.org, nsc@kernel.org, ojeda@kernel.org,
	masahiroy@kernel.org, linux@weissschuh.net, tamird@kernel.org,
	rostedt@goodmis.org, ihor.solodrai@linux.dev, ritesh.list@gmail.com,
	maddy@linux.ibm.com, peterz@infradead.org
Subject: Re: [PATCH v2] char: nvram: Remove unused nvram_mutex to fix
 -Wunused-variable warning
Message-ID: <2026032305-cross-sensuous-8f4a@gregkh>
References: <20260323073220.25798-1-venkat88@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323073220.25798-1-venkat88@linux.ibm.com>

On Mon, Mar 23, 2026 at 01:02:20PM +0530, Venkat Rao Bagalkote wrote:
> v2:
>   - Added missing Suggested-by tag from Ritesh Harjani (IBM)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

