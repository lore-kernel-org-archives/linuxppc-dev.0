Message-ID: <3F3D4B2B.9000700@laurelnetworks.com>
Date: Fri, 15 Aug 2003 17:05:47 -0400
From: "Michael J. Accetta" <mja@laurelnetworks.com>
MIME-Version: 1.0
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hardware Requrements for Linux on 405GPr
References: <21518-79162@sneakemail.com> <3F3BEE49.4050806@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle wrote:

> An RTC is not required for Linux. Many designs I have seen do not have
> one. However, an RTC is an excellent device to have available! Various
> applications and services may require a consistant, ever increasing
> time. NFS is the one that comes to mind immediatly. If the device is
> rebooted and the time goes back to default, NFS may have problems.

You can defintely run into problems with NFS and no RTC. We have a setup
like this and without a RTC, NFS would end up allocating (I think)
request id's based on the time that might be cached on the server to
handle replay. With the time always starting at 0, different requests
with the same id could be issued from the card across boot sessions and
the server would have cached the old request, producing some confusing
results when it replied to the cached rather than new request. Our
solution was to add a TIME protocol probe in the ipv4 BOOTP path so the
card always got the right time before continuing the boot.

Mike Accetta


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
