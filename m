Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 8812D67BC6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 01:56:02 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2693205ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 04 Dec 2006 06:56:00 -0800 (PST)
Message-ID: <528646bc0612040655j60a7e93emb151ddd55e6db984@mail.gmail.com>
Date: Mon, 4 Dec 2006 07:55:59 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
Subject: Re: [LIBFDT] Fixup byteswapping code
In-Reply-To: <20061204071629.GC32026@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11650491414017-git-send-email-grant.likely@secretlab.ca>
	<20061204015329.GA4790@localhost.localdomain>
	<528646bc0612032118i689e9c83gdfc841a3d7b91fcf@mail.gmail.com>
	<20061204055217.GA32026@localhost.localdomain>
	<528646bc0612032233y573dfbcdk29a969e19540242a@mail.gmail.com>
	<20061204071629.GC32026@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/4/06, David Gibson <david@gibson.dropbear.id.au> wrote:
> I do have one idea for better error handling: I'd like to put in
> something defined in the the libfdt_env.h (which is designed to be
> replaced when libfdt is compiled in different environments) to report
> an error.  That would be invoked every time a libfdt function exits
> with an error - I would envisage it calling through to a user supplied
> function pointer.
>
> In many practical situations, I think most libfdt errors would be the
> result of something unrecoverable problem (such as a corrupted device
> tree blob), the callback could just print an error (by whatever means
> is appropritate for the environment) and bail out, avoiding the need
> for checking return values.  At least for the "serious" errors
> (BADMAGIC, BADSTRUCTURE and so forth).  NOTFOUND (and maybe TRUNCATED)
> would need to be passed back as a return value still, since that can
> certainly occur in a legitimate test.

Yeah, that's not a bad idea.  That way the complexity of making it
thread safe is left with the execution environment, not with libfdt,
and it still leaves the possibility of application code retrieving the
error code if it is interested....  Still not ideal, but of the
options presented, I like this one best.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
