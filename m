Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 30FE5DDEF7
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:37:12 +1000 (EST)
Message-ID: <4667370D.2060706@am.sony.com>
Date: Wed, 06 Jun 2007 15:37:01 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [patch 03/18] PS3: Use __maybe_unused
References: <20070606024407.786638029@am.sony.com> >	
	<46662315.30004@am.sony.com>
	<1181102745.5536.18.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1181102745.5536.18.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2007-06-05 at 19:59 -0700, Geoff Levand wrote:
>> Change the PS3 debug routines from using the GCC specific
>> '__attribute__ ((unused))' to the preprocessor macro
>> __maybe_unused.
> 
> I'm confused. If DEBUG is defined then they're used, if it's not then
> they're not built.

Some are for actual 'debugging' use, calls to be added later, not
just for verbose output.  Others are for verbose output when DEBUG
is defined.  I have it setup so they are always built to do the
syntax check, but removed by the optimizer when not used.  I was
planning to remove these routines sometime in the future, but want
to keep them in until the code gets stable.

-Geoff
