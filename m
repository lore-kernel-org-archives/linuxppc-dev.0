Date: Sun, 3 Nov 2002 13:45:18 -0500
Subject: Re: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v546)
Cc: David Edelsohn <dje@watson.ibm.com>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
To: Aldy Hernandez <aldyh@redhat.com>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
In-Reply-To: <m3r8e2ld89.fsf@frogsleap.quesejoda.com>
Message-Id: <66242FA2-EF5C-11D6-81A1-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> I also vaguely recall that Geoff has a list of ABI changes pending.
> Perhaps we should do all these at the same time.
>
Current violations of the abi for ppc linux include:

- missing support for small structure return values in register pairs
r3, r4

- missing passing floats as doubles on the outgoing parameter stack
aligned to 8
   (I think that is how the abi should be interpreted but)

But changing either of these will necessitate rewrite of the libffi
code used by gcj,
the JDK code (sys_invokeNative and etc), the mozilla code, the gcc
bridge code in
OpenOffice, and I am sure there are a number of other projects that use
some form of call
on the fly stuff for components.

So if these are the abi changes Geoff has waiting, we should really
think about a
simultaneous push of patches to many of these projects to help them
maintain
support for ppc linux.

My 2 cents.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
