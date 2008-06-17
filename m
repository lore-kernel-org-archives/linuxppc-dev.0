Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 96DA5DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 17:28:27 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1099786anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 00:28:26 -0700 (PDT)
Message-ID: <fa686aa40806170028t2ccb679k22d2d3cea793ebc1@mail.gmail.com>
Date: Tue, 17 Jun 2008 01:28:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 2/4] spi: split up spi_new_device() to allow two stage
	registration.
In-Reply-To: <fa686aa40805232343x20031560j5659d203e25f494@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193608.28030.34968.stgit@trillian.secretlab.ca>
	<200805211717.13206.david-b@pacbell.net>
	<fa686aa40805232343x20031560j5659d203e25f494@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 24, 2008 at 12:43 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Wed, May 21, 2008 at 6:17 PM, David Brownell <david-b@pacbell.net> wrote:
>> On Friday 16 May 2008, Grant Likely wrote:
>>>
>>> This patch splits the allocation and registration portions of code out
>>> of spi_new_device() and creates three new functions; spi_alloc_device(),
>>> spi_register_device(), and spi_device_release().
>>
>> I have no problem with the first two, but why the last?
>>
>> If the devices are always allocated by spi_alloc_device() as
>> they should be -- probably through an intermediary -- the
>> only public function necessary for that cleanup should be
>> the existing spi_dev_put().
>
> Ah, okay.  I'm still a bit fuzzy on the device model conventions.
> I'll remove that then.

I've dug into this some more.  spi_alloc_device only allocates the
memory.  It doesn't call device_initialize() to initialize the kref.
All of that behaviour is handled within device_register().  Therefore
if a driver uses spi_alloc_device() and then if a later part of the
initialization fails before spi_register_device() is called, then the
alloc'd memory needs to be freed, but spi_dev_put() won't work because
the kobj isn't set up so I need another function to handle freeing it
in on a failure path.

Should I switch things around to do device_initialize() in the alloc
function and call device_add() instead of device_register() in the
spi_register_device() function?  Is that sufficient to make
put_device() work?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
