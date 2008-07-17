Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 64749DDEFF
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 23:55:19 +1000 (EST)
Message-ID: <487F5108.9050207@windriver.com>
Date: Thu, 17 Jul 2008 10:02:48 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org,
	jdl@jdl.com
Subject: Re: [PATCH] dtc: supply a definition for YYRHSLOC if there isn't one
References: <1216230837-17557-1-git-send-email-paul.gortmaker@windriver.com>
	<20080717054713.GF21564@yookeroo.seuss>
In-Reply-To: <20080717054713.GF21564@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Jul 16, 2008 at 01:53:57PM -0400, Paul Gortmaker wrote:
>   
>> It seems that some machines, like a default RHEL4 install, will
>> not have a definition for YYRHSLOC, and that prevents building
>> dtc.  This supplies what appears to be the standard definition
>> for it in the event that the host system does not have it defined.
>>     
>
> I'm pretty uneasy about this, since it relies on knowing the internals
> of how bison manages its tokens.  What version of bison is it in RHEL4
> that causes the trouble?
>   

Right -- well, I trust your judgment on something like that more than
my own.   The version in question is "bison (GNU Bison) 1.875c".

When I was digging around, the definitions all pretty much came back
with the one I'd used, but I do understand your concern.

> In fact I have a feeling that the extra 'file' field in YYLTYPE never
> gets used, which means we could just ditch our custom YYLLOC_DEFAULT
> definition, which would be a better idea, IMO, except that we'll
> probably want the file info back at some point.
>
> Ick.
>   

Sorry to be the bearer of bad news   :-)   If you have an alternate fix that
you'd like me to test, I'd be happy to do so;  I've still access to the old
machine on which the problem report was 1st bounced to me from.  If I
tried to fix it in any other way than what I did, I'd probably hurt 
myself...

Paul.
