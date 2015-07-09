Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCC731A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 22:59:36 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 138101402A0
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 22:59:35 +1000 (AEST)
Date: Thu, 9 Jul 2015 07:59:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Dinar valeev <k0da@opensuse.org>, aik@ozlabs.ru, linuxppc-dev@ozlabs.org,
 slof@lists.ozlabs.org, Dinar Valeev <dvaleev@suse.com>,
 nikunj@linux.vnet.ibm.com
Subject: Re: [PATCH v2] Caps in not always shift
Message-ID: <20150709125916.GA2990@gate.crashing.org>
References: <1436374064-4116-1-git-send-email-k0da@opensuse.org>
 <20150709080048.1fda0d0f@thh440s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150709080048.1fda0d0f@thh440s>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 09, 2015 at 08:00:48AM +0200, Thomas Huth wrote:
> >  /**
> > + * Checks if keypos is a latin key
> > + * @param  keypos
> > + * @return -
> > + */
> > +void check_latin(uint8_t keypos)
> > +	if (keypos > KEYP_LATIN_A || keypos < KEYP_LATIN_Z) {
> > +		return true;
> > +	} else {
> > +		return false;
> > +	}
> > +
> 
> That does not look like valid C to me ... "void" return type and
> returning true or false ...

Valid C90, not valid C99 or C11.  Any sane compiler will warn in any
case :-)

> and what about the outermost curly braces?

Yeah, this doesn't compile at all.

> Anyway, you could even write this much more simple without if-statement
> instead:
> 
> bool check_latin(uint8_t keypos)
> {
> 	return keypos > KEYP_LATIN_A || keypos < KEYP_LATIN_Z;
> }

It's a pretty bad name, "check" doesn't give an indication of what the
polarity of the return value is.

I would expect something more like

bool is_latin(uint8_t keypos)
{
	return keypos >= KEYP_LATIN_A && keypos <= KEYP_LATIN_Z;
}

or

bool is_not_latin(uint8_t keypos)
{
	return keypos < KEYP_LATIN_A || keypos > KEYP_LATIN_Z;
}

The proposed code would always return true?


Segher
