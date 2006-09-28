Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1159401139.7584.82.camel@basalt.austin.ibm.com>
References: <20060831184020.GA13494@mag.az.mvista.com>
	<17662.17895.852128.729679@cargo.ozlabs.ibm.com>
	<20060907003625.GA15533@mag.az.mvista.com>
	<1157615011.18137.14.camel@diesel>
	<20060907182717.GC4398@mag.az.mvista.com>
	<1157667816.5220.30.camel@basalt.austin.ibm.com>
	<20060908005630.GA9823@mag.az.mvista.com>
	<17665.28367.380866.565218@cargo.ozlabs.ibm.com>
	<20060919194527.GD11361@mag.az.mvista.com>
	<17690.64482.319084.61866@cargo.ozlabs.ibm.com>
	<6897081F-DDAC-462A-8D4D-EE613231CA4B@kernel.crashing.org>
	<1159401139.7584.82.camel@basalt.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FCEE727C-650A-41F1-85D3-270BFDF7B205@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: common flatdevtree code
Date: Thu, 28 Sep 2006 02:51:52 +0200
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Or unpack the tree before you operate on it.  You can pack it
>> again later if you need to pass it as a flat tree again (or the
>> bootwrapper could implement a real OF client interface, which
>> is useful for many more things!)
>>
>> A flat contiguous blob of bytes is convenient to pass around,
>> but not such a great data structure for basically anything else ;-)
>
> I agree; I think this data structure's design is explicitly static,  
> and
> now we're trying to dynamically edit it.
>
> We essentially need to do unpack/pack now whenever the size of the
> structure changes (e.g. changing a property size, adding or removing
> anything). Making that explicit (and one-time) might be a good idea:
>         tree = ft_unpack(blob);
>         n = ft_find_node(tree, "/node");
>         ft_set_prop(n, "property", value, len);
>         ...
>         blob = ft_pack(tree);

And then everything but ft_{un,}pack() don't actually operate on
a flat tree anymore; so change the prefix?  How about using of_
instead :-)

[Do you see where this is going? :-) ]


Segher
