Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 030B5DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jun 2007 08:59:59 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1861129wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 04 Jun 2007 15:59:57 -0700 (PDT)
Message-ID: <fa686aa40706041559i43c03574kfc6ca7574e16ab3b@mail.gmail.com>
Date: Mon, 4 Jun 2007 16:59:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: Using Cypress EZ-Host on ML403/5
In-Reply-To: <87wszqucpr.fsf@p4.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4623A197.6000104@computing.dundee.ac.uk>
	<528646bc0704190717o14da4b58r5ef69a8e77ade198@mail.gmail.com>
	<87vefsmoaj.fsf@sleipner.barco.com>
	<528646bc0704190750r4b6d76y72a862c249fa0520@mail.gmail.com>
	<9305ca410704240042w7f8b12fau331a6407f45be74c@mail.gmail.com>
	<528646bc0704240637sd3797a2q5ae48db19155ba61@mail.gmail.com>
	<9305ca410704270141y66928deyab59300b8c5ccb95@mail.gmail.com>
	<528646bc0704301223q2024505ah5308147ba6eead0a@mail.gmail.com>
	<528646bc0705021408o1e1f25d7pa81905081d06ed8e@mail.gmail.com>
	<87wszqucpr.fsf@p4.be.48ers.dk>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/2/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
>  Grant> Some block devices seem to be giving me grief.  I have no problem with
>  Grant> my SanDisk ImageMate CF reader.  However, I've got a SanDisk Curzer
>  Grant> Micro that gets reset during transfers.  Is this something you've seen
>  Grant> before?  Log output is below.
>
> Yeah, I've also had quite varied success with USB sticks - Some work
> just fine, others not at all. I'm still trying to figure out what goes
> wrong..

I think I've solved this problem.  The driver wasn't checking the
active flag on TDs in check_td_list().  If the c67x00 ran out of time
in a frame, not all the TDs would get processed.  Without this check
the HCD would interpret unprocessed TDs as successfully completed.

I've also got a fair number of comments/changes on the driver in patch
form.  I'll send it to the list shortly.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
