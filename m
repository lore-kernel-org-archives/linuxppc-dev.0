Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF7DC48260
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Feb 2024 19:20:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TZB3f4DHGz3vYX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Feb 2024 06:19:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TZB364jc0z2xWR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2024 06:19:29 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 41DJCu2k018865;
	Tue, 13 Feb 2024 13:12:56 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 41DJCtmj018864;
	Tue, 13 Feb 2024 13:12:55 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 13 Feb 2024 13:12:54 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] tty: hvc-iucv: fix function pointer casts
Message-ID: <20240213191254.GA19790@gate.crashing.org>
References: <20240213101756.461701-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213101756.461701-1-arnd@kernel.org>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-serial@vger.kernel.org, Justin Stitt <justinstitt@google.com>, Jiri Slaby <jirislaby@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 13, 2024 at 11:17:49AM +0100, Arnd Bergmann wrote:
> clang warns about explicitly casting between incompatible function
> pointers:
> 
> drivers/tty/hvc/hvc_iucv.c:1100:23: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1100 |         priv->dev->release = (void (*)(struct device *)) kfree;
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Such a cast of course is explicitly allowed by 6.3.2.3/8, only calling a
function using a non-compatible type is UB.  This warning message is
quite misleading.  Doubly so because of the -Werror, as always.

Your proposed new code of course is nice and simple (albeit a bit bigger
than it was before, both source and binary).  Such is life ;-)


Segher
