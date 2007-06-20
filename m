Return-Path: <adetsch@br.ibm.com>
Message-ID: <46797776.3070202@br.ibm.com>
Date: Wed, 20 Jun 2007 15:52:38 -0300
From: =?ISO-8859-1?Q?Andr=E9_Detsch?= <adetsch@br.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [patch 4/5] cell: saving spus information for	kexec
	crash
References: <20070618224247.972139855@arndb.de>
	<20070618224923.498962312@arndb.de>
	<1182211119.23887.3.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1182211119.23887.3.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Luke Browning <LukeBrowning@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Lucio Jose Herculano Correia <luciojhc@br.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Michael Ellerman wrote:
> On Tue, 2007-06-19 at 00:42 +0200, Arnd Bergmann wrote:
>> plain text document attachment (cell-spus-info-kexec-crash-1.diff)
>> From: Andre Detsch <adetsch@br.ibm.com>
>> This patch adds support for investigating spus information after a
>> kernel crash event, through kdump vmcore file.
>> Implementation is based on xmon code, but the new functionality was
>> kept independent from xmon.
>>
>> Signed-off-by: Lucio Jose Herculano Correia <luciojhc@br.ibm.com>
>> Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
>> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> 
> 
> I'd like to have this patch share the emergency stopping logic with the
> xmon code, I'll try and get a patch done in the next few days.
> 

Hi Michael,

What aspect of the patch do you think would benefit from sharing logic 
with xmon? The structures (struct crash_spu + crash_register_spus 
function) or the stop spus logic itself (crash_kexec_stop_spus)? Or both?

My first approach was actually to use the same structure and code as 
xmon (as you might remember from an private email I've sent before 
posting the patch). However, talking with Luke, we decided to keep xmon 
and crash data independent from each other, since he was interested on 
eventually allowing xmon to be run before the second kernel gets loaded. 
  So, having a separate structure for crash info would allow us to save 
the exact state when the crash occurred, no matter of what the user did 
while running xmon.

Best regards,

--
Andre Detsch
