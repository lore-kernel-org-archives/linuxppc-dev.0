Return-Path: <matt@ozlabs.org>
Message-ID: <4D93B84D.7040500@ozlabs.org>
Date: Thu, 31 Mar 2011 10:10:05 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [PATCH v2 5/5] xhci: Remove recursive call to xhci_handle_event
References: <4D8C47D8.4020901@ozlabs.org> <4D8C8F2B.9090808@ru.mvista.com>
	<4D90142C.4050206@ozlabs.org>
	<20110329200017.GA25480@dtor-ws.eng.vmware.com>
In-Reply-To: <20110329200017.GA25480@dtor-ws.eng.vmware.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sarah.a.sharp@linux.intel.com, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30/03/11 07:00, Dmitry Torokhov wrote:
> On Sunday, March 27, 2011 09:53:00 pm Matt Evans wrote:
>> @@ -2282,7 +2284,7 @@ hw_died:
>>  	/* FIXME this should be a delayed service routine
>>  	 * that clears the EHB.
>>  	 */
>> -	xhci_handle_event(xhci);
>> +	while (xhci_handle_event(xhci)) {}
>>
> 
> I must admit I dislike the style with empty loop bodies, do you think
> we could have something like below instead?

Well, although I don't mind empty while()s at all (they're clean and obvious
IMHO) I would remove an empty blightful while loop with something like this:

do {
	ret = xhci_handle_event(xhci);
} while (ret > 0);

;-) (Not sure that refactoring its contents into the IRQ handler is a good idea,
if that area's going to be revisited soon to extend error
handling/reporting.)

Cheers,


Matt
