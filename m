Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24BD21A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 16:01:01 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4E3AD140AF3
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 16:00:59 +1000 (AEST)
Date: Thu, 9 Jul 2015 08:00:48 +0200
From: Thomas Huth <thuth@redhat.com>
To: Dinar valeev <k0da@opensuse.org>
Cc: linuxppc-dev@ozlabs.org, aik@ozlabs.ru, nikunj@linux.vnet.ibm.com, Dinar
 Valeev <dvaleev@suse.com>, slof@lists.ozlabs.org
Subject: Re: [PATCH v2] Caps in not always shift
Message-ID: <20150709080048.1fda0d0f@thh440s>
In-Reply-To: <1436374064-4116-1-git-send-email-k0da@opensuse.org>
References: <1436374064-4116-1-git-send-email-k0da@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 Hi!

Please CC to slof@lists.ozlabs.org now that we've finally got a SLOF
mailing list :-) !

On Wed,  8 Jul 2015 18:47:44 +0200
Dinar valeev <k0da@opensuse.org> wrote:
...
>  /**
> + * Checks if keypos is a latin key
> + * @param  keypos
> + * @return -
> + */
> +void check_latin(uint8_t keypos)
> +	if (keypos > KEYP_LATIN_A || keypos < KEYP_LATIN_Z) {
> +		return true;
> +	} else {
> +		return false;
> +	}
> +

That does not look like valid C to me ... "void" return type and
returning true or false ... and what about the outermost curly braces?

Anyway, you could even write this much more simple without if-statement
instead:

bool check_latin(uint8_t keypos)
{
	return keypos > KEYP_LATIN_A || keypos < KEYP_LATIN_Z;
}

 Thomas
