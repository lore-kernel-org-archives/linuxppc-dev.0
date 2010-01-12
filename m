Return-Path: <francesco.virlinzi@st.com>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2BD691007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 20:19:07 +1100 (EST)
Message-ID: <4B4C376C.6080705@st.com>
Date: Tue, 12 Jan 2010 09:48:44 +0100
From: Francesco VIRLINZI <francesco.virlinzi@st.com>
MIME-Version: 1.0
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Subject: Re: [RFC,PATCH 1/7 v2] Add a common struct clk
References: <1263279511.160551.332624337260.1.gpush@pororo>
In-Reply-To: <1263279511.160551.332624337260.1.gpush@pororo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeremy
In November I already sent a proposal on
  a generic linux clk framework.
On that I would suggest:

>
> +struct clk {
> +	const struct clk_operations *ops;
>    
            spinlock_t lock;
            const char *name;
            int id;
            unsigned long rate;
> +};
> +
> +struct clk_operations {
>    
                int (*init)(struc clk *);
> +       int             (*enable)(struct clk *);
> +       void            (*disable)(struct clk *);
> +       unsigned long   (*get_rate)(struct clk *);
> +       void            (*put)(struct clk *);
> +       long            (*round_rate)(struct clk *, unsigned long);
> +       int             (*set_rate)(struct clk *, unsigned long);
> +       int             (*set_parent)(struct clk *, struct clk *);
> +       struct clk*     (*get_parent)(struct clk *);
> +};
>    

+static inline int clk_enable(struct clk *clk)
+{
	unsigned long flags;
	int ret = 0;
+	if (clk->ops->enable) {
		spinlock_irq_save(&clk->lock, flags);
+		ret = clk->ops->enable(clk);
		spinlock_irq_restore(&clk->lock, flags);
	}
+	return 0;
+}

Something similar in the other function...

> +
> +static inline unsigned long clk_get_rate(struct clk *clk)
> +{
> +	if (clk->ops->get_rate)
> +		return clk->ops->get_rate(clk);
>    
> 	return clk->rate;
> +}
>
>    
Moreover if you support .set_parent and .get_parent  a .parent field in 
the struct clk
  is useful.

As

struct clk {
const struct clk_operations *ops;

     spinlock_t lock;
     const char *name;
     int id;
     unsigned long rate;
     struct clk *parent;
};

Regards
  Francesco
