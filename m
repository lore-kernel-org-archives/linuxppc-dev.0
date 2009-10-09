Return-Path: <joe@perches.com>
Subject: Re: [RFC] scripts/get_maintainer: add emails based on keywords in
	the patch
From: Joe Perches <joe@perches.com>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <1255084379-12954-1-git-send-email-w.sang@pengutronix.de>
References: <1255084379-12954-1-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 04:23:26 -0700
Message-Id: <1255087406.16347.108.camel@Joe-Laptop.home>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-09 at 12:32 +0200, Wolfram Sang wrote:

> +my %keywords_to_mail = (
> +	'of_get_property' => 'L: devicetree-discuss@lists.ozlabs.org',

maybe: '\bof_get_property\b'

> +	    # Check the lines which a patch modifies for keywords; add mail if found.
> +	    } elsif (m/^[+-].*($keywords_to_mail_match)/o) {
> +		(my $keyword_mail = $keywords_to_mail{$1}) =~ s/^([LM]): //;
> +		push( @{ ($1 eq 'L') ? \@list_to : \@email_to }, $keyword_mail );
> +	   }

If this facility is desired by many others, it might be
better to have a separate file of 'regex generates email'
read at initialization.
