Message-ID: <40B907FA.8050904@246tNt.com>
Date: Sun, 30 May 2004 00:00:26 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Making a "paged" sram aread appear as linear.
References: <40B8EECF.7050503@246tNt.com>
In-Reply-To: <40B8EECF.7050503@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



After a little chat on IRC with 'ebs', it seems that changing the
vm_operations_struct of the vm_area_struct I get with the mmap call.
I'd like to let the cache be enabled for performance. So for me the
steps when the user request access to a segment different from the
current one are :

1) Flush the cache of the current mapped segment
2) Unmap the segment
3) Write to the control reg to select another segment
4) Map the new area
5) Do what the user requested

Any other issues I should take care of ?


Sylvain Munaut


Sylvain Munaut wrote:

|
|
| Hi,
|
| Let's say I have a device on the SRAM bus that an internal RAM of
| 8Mbyte. It's connected to the MCU on it's SRAM bus. But on the SRAM
|  bus, It only has two window of 64k. One is all the control
| registers and the other can be mapped to any 64k segment of the
| device internal RAM.
|
| Now, I'd like that a user space process can mmap / open / read /
| write this aread as if it was linear. So what I thinked of was to
| allocate a contiguous area of 8Mb, then only really map the current
| active 64k area and then set a "handler" to catch access to the
| others area so it can set the active page. The problem is that I
| have no idea if that's possible, or how to do it.
|
| Any advice, pointers ?
|
|
| Sylvain Munaut
|
|
|


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
