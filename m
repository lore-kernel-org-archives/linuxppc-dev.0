Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1C9B4B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 01:36:50 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6DDD2DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 01:36:49 +1000 (EST)
Message-Id: <5B1EBBDB-CCB6-4D87-BBB2-912D34F016F1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Alan Modra <amodra@bigpond.net.au>
In-Reply-To: <20090710041123.GD3181@bubble.grove.modra.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: binutils 2.19 issue with kernel link
Date: Fri, 10 Jul 2009 10:34:35 -0500
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090708233954.GA3181@bubble.grove.modra.org>
	<E6EB8DA7-8B38-4C97-BE3C-4649DFA295C8@kernel.crashing.org>
	<AB02ECF3-9C72-436B-A946-CBCCD3859762@kernel.crashing.org>
	<20090709044007.GB3181@bubble.grove.modra.org>
	<4B3B917C-C8B0-416B-888D-13E6C0645BF8@kernel.crashing.org>
	<4A5645A9.3080003@freescale.com>
	<20090710041123.GD3181@bubble.grove.modra.org>
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	bug-binutils@gnu.org, Edmar Wienskoski-RA8797 <edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2009, at 11:11 PM, Alan Modra wrote:

> Hmm, having said all that, the following linker patch seems reasonable
> to me and probably won't break anything else (always some risk).
> Please test it for me.
>
> Index: ld/ldlang.c
> ===================================================================
> RCS file: /cvs/src/src/ld/ldlang.c,v
> retrieving revision 1.311
> diff -u -p -r1.311 ldlang.c
> --- ld/ldlang.c	25 Jun 2009 13:18:46 -0000	1.311
> +++ ld/ldlang.c	10 Jul 2009 04:04:57 -0000
> @@ -1615,10 +1615,12 @@ output_prev_sec_find (lang_output_sectio
>    idea is to skip over anything that might be inside a SECTIONS {}
>    statement in a script, before we find another output section
>    statement.  Assignments to "dot" before an output section statement
> -   are assumed to belong to it.  An exception to this rule is made  
> for
> -   the first assignment to dot, otherwise we might put an orphan
> -   before . = . + SIZEOF_HEADERS or similar assignments that set the
> -   initial address.  */
> +   are assumed to belong to it, except in two cases;  The first
> +   assignment to dot, and assignments before non-alloc sections.
> +   Otherwise we might put an orphan before . = . + SIZEOF_HEADERS or
> +   similar assignments that set the initial address, or we might
> +   insert non-alloc note sections among assignments setting end of
> +   image symbols.  */
>
> static lang_statement_union_type **
> insert_os_after (lang_output_section_statement_type *after)
> @@ -1662,7 +1664,12 @@ insert_os_after (lang_output_section_sta
> 	  continue;
> 	case lang_output_section_statement_enum:
> 	  if (assign != NULL)
> -	    where = assign;
> +	    {
> +	      asection *s = (*where)->output_section_statement.bfd_section;
> +
> +	      if (s == NULL || (s->flags & SEC_ALLOC) != 0)
> +		where = assign;
> +	    }
> 	  break;
> 	case lang_input_statement_enum:
> 	case lang_address_statement_enum:
>
> -- 

This patch seems to "fix" things.

- k
